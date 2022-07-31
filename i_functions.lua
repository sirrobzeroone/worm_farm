--------------------------------------------------------------
--       _ _ _                  _____                       --
--      | | | |___ ___ _____   |   __|___ ___ _____         --
--      | | | | . |  _|     |  |   __|_.||  _|     |        --
--      |_____|___|_| |_|_|_|  |__|  |__||_| |_|_|_|        --
--------------------------------------------------------------
--                     Worm Farm                            --
--------------------------------------------------------------
--                     Functions                            --
--------------------------------------------------------------
-- translation
local S = worm_farm.translate

-- register worm food/water
function worm_farm.register_worm_food_water(name, time_amount, rtn_empty, flag)	
	local insert_table = worm_farm.worm_foods
	local sub_tab = "ind"
	local sec_wat = "sec"
	
	if flag == "w" then
		insert_table = worm_farm.worm_hydrate
		sec_wat = "water"
	end

	if string.find(name, "group:") then
		sub_tab = "grp"	
	end
	
	table.insert(insert_table[sub_tab], {name = name  ,[sec_wat] = time_amount, empty = rtn_empty})	
end

-- register dirt nodes drop worms
function worm_farm.register_worm_drop(dirt_name, rare)	
		
	local existing_drops
	local new_drops = {}
	new_drops.items = {}			
	local is_insert = true
	
	if type(minetest.registered_nodes[dirt_name].drop) == "table" then
						
		existing_drops = table.copy(minetest.registered_nodes[dirt_name].drop)
		new_drops.max_items = existing_drops.max_items + 1
		
		-- drop items structure has 2x word "items" as keys one below 
		-- the other in the table structure easy to get confused
		-- https://minetest.gitlab.io/minetest/definition-tables/#node-definition
		
		for _, item in pairs(existing_drops.items) do          -- top items														
			item.rarity = item.rarity or 0 					   -- catch nils turn to 0
			
			-- our worm item needs to be inserted 
			-- in the correct rarity order
			if rare < item.rarity then
				if item.rarity == 0 then item.rarity = nil end -- catch 0 turn back to nil
				table.insert(new_drops.items,item)
			
			elseif rare >= item.rarity and is_insert then
				if item.rarity == 0 then item.rarity = nil end -- catch 0 turn back to nil
				table.insert(new_drops.items,{items = {worm_farm.nodes.worm},rarity = rare})
				table.insert(new_drops.items,item)
				is_insert = false 
			else
				if item.rarity == 0 then item.rarity = nil end -- catch 0 turn back to nil
				table.insert(new_drops.items,item)						
			end
	
		end			
	else
		existing_drops = minetest.registered_nodes[dirt_name].drop
		new_drops.max_items = 2
		
		table.insert(new_drops.items,{items = {worm_farm.nodes.worm},rarity = rare})
		table.insert(new_drops.items,{items = {existing_drops}})
	end
	
	minetest.override_item(dirt_name, {
		drop = new_drops
	})	
end

-- node/item name/group check - flag is optional
function worm_farm.name_group(thing_name, flag)				
	local check_table = worm_farm.worm_foods
	local found = false	
	local thing_def
	
	if flag == "w" then
		check_table = worm_farm.worm_hydrate
	end
	
	-- name check first
	for _, item in ipairs(check_table.ind) do				
		if item.name == thing_name then
			found = true
			thing_def = item
			break
		end
	end	
	
	-- group check second
	if not found then
		for _, item in ipairs(check_table.grp) do				
			local name_split = string.split(item.name, ":")
			local group = minetest.get_item_group(thing_name, name_split[2])
			if group ~= 0 then
				found = true
				thing_def = item
				break
			end
		end		
	end
	-- found must be first result returned
	return found, thing_def
end

-- worm farm formspec
function worm_farm.worm_farm_form(pos)
	local n_meta = minetest.get_meta(pos)
	local w_lvl = n_meta:get_int("water_level")
	local p_lvl = n_meta:get_int("worm_pop")
	local time_end = n_meta:get_int("time_end")
	local time_cnt = n_meta:get_int("time_cnt")
	local pop_sum = S("Critical")
	local w_lvl_p = math.floor((w_lvl/worm_farm.water_max)*100)
	local p_lvl_p = math.floor((p_lvl/worm_farm.pop_max)*100)
	local t_lvl_p = math.floor((time_cnt/time_end)*100)
	local l_name = pos.x..","..pos.y..","..pos.z 
	local bonemeal = ""
	local tt_worm_food = S("Worm Food")
	local tt_water_stored = S("Water Stored")
	local tt_worm_pop = S("Worm Population")
	if p_lvl > worm_farm.pop_crit and p_lvl < worm_farm.pop_med then pop_sum = S("Low")
	elseif p_lvl >= worm_farm.pop_med and p_lvl < worm_farm.pop_high then pop_sum = S("Medium")
	elseif p_lvl >= worm_farm.pop_high then pop_sum = S("High")
	end
	
	if worm_farm.is_bonemeal and worm_farm.is_vessels then
		bonemeal = "list[nodemeta:"..l_name..";empty_bottle;3.25,3.5;1,1;0]"..
					"image[3.25,3.5;1,1;"..worm_farm.textures.bottle.."^[opacity:32]"
	end
	
	local form = "formspec_version[4]"..
				 "size[10.25,10.25]"..
				 "list[nodemeta:"..l_name..";worm_food;2,1;3,1;0]"..
				 "tooltip[2,1;3,1;"..tt_worm_food.."]"..
				 "image[1.75,2.25;1,1;"..worm_farm.textures.dirt.."]"..
				 "image[2.75,2.25;1,1;"..worm_farm.textures.dirt.."]"..
				 "image[3.75,2.25;1,1;"..worm_farm.textures.dirt.."]"..
				 "image[4.75,2.25;1,1;"..worm_farm.textures.dirt.."]"..bonemeal..
				 "image[6,2.25;1,1;"..worm_farm.textures.worm.."^[colorize:#3a3a3a:200^[lowpart:"..t_lvl_p..":"..worm_farm.textures.worm.."]"..
				 "image[0.4,0.5;0.5,3.5;worm_farm_meter_back.png^[lowpart:"..w_lvl_p..":worm_farm_meter_water.png]"..				 
				 "image[0.4,0.5;0.5,3.5;worm_farm_meter_front.png]"..
				 "image[0.4,4.15;0.5,0.5;worm_farm_icon_fluid_water.png]"..
				 "tooltip[0.4,4.15;0.75,0.75;"..tt_water_stored..": "..w_lvl_p.."%]"..				 
				 "image[1.25,0.5;0.25,3.5;worm_farm_meter_pop_back.png^[lowpart:"..p_lvl_p..":worm_farm_meter_pop_pop.png]"..
				 "image[1.25,0.5;0.25,3.5;worm_farm_meter_pop_front.png]"..
				 "image[1.15,4.15;.5,.5;"..worm_farm.textures.worm.."]"..
				 "tooltip[1.15,4.15;0.75,0.75;"..tt_worm_pop..": "..pop_sum.."]"..
				 "list[nodemeta:"..l_name..";output;7.25,1;2,3;0]"..
				 "list[current_player;main;0.25,5;8,1;0]"..
				 "list[current_player;main;0.25,6.5;8,3;8]"
	return form
end

-- worm breeding/replication code
function worm_farm.timer_replicate(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	local n_meta = minetest.get_meta(pos)
	local rep_cycle = n_meta:get_int("rep_cycle")
	local time_end = n_meta:get_int("time_end")
	local time_cnt = n_meta:get_int("time_cnt")
	local worm_pop = n_meta:get_int("worm_pop")
	local worm_tea = n_meta:get_int("worm_tea")
	local worm_dirt = n_meta:get_int("worm_dirt")
	local water_level = n_meta:get_int("water_level")
	local inv = n_meta:get_inventory()
	local worm_stack = ItemStack(worm_farm.nodes.worm.." 1")
	local bottle_stack = ItemStack(worm_farm.nodes.bottle.." 1")
	local tea_stack = ItemStack("worm_farm:worm_tea 1")
	local dirt_stack = ItemStack(worm_farm.nodes.dirt.." 1")
	
	if time_cnt >= time_end then  
		if rep_cycle == 0 and inv:is_empty("worm_food") then
			n_meta:set_int("time_cnt", 0)
			n_meta:set_string("formspec", worm_farm.worm_farm_form(pos))
			return false  -- false timer no longer runs 		
		
		elseif not inv:room_for_item("output", worm_stack) then
			n_meta:set_int("time_cnt", 0)
			n_meta:set_string("formspec", worm_farm.worm_farm_form(pos))
			return false 
			-- should never end up here but left as catch
		
		else
			-- This else produces a worm and sets up the next timer cycle		
			-- add a worm
			if rep_cycle == 1 then
				inv:add_item("output", worm_stack)
			
			-- bonus worm(s) if population is high
				if worm_pop >= worm_farm.pop_high then
					for inv_loc = 1,worm_farm.pop_high_b,1 do
						if inv:room_for_item("output", worm_stack) then
							inv:add_item("output", worm_stack)	
						end
					end		
				end
				
				-- check worm_tea
				if worm_farm.is_bonemeal and not inv:is_empty("empty_bottle") then
					if worm_tea >= worm_farm.worm_tea then
						
						if inv:room_for_item("output", tea_stack) then
							inv:add_item("output", tea_stack)
							inv:remove_item("empty_bottle", bottle_stack)
							n_meta:set_int("worm_tea",0)
						else
							n_meta:set_string("formspec", worm_farm.worm_farm_form(pos))
							return false
						end					
					else						
						if worm_pop >= worm_farm.pop_high then							
							n_meta:set_int("worm_tea",worm_tea+1+worm_farm.pop_high_b)
						else
							n_meta:set_int("worm_tea",worm_tea+1)						
						end
					end
				end
				
				-- check worm_dirt
				if worm_dirt >= worm_farm.dirt then
					if inv:room_for_item("output", dirt_stack) then
						inv:add_item("output", dirt_stack)
						n_meta:set_int("worm_dirt",0)
					else
						n_meta:set_int("time_cnt", 0)
						n_meta:set_string("formspec", worm_farm.worm_farm_form(pos))
						return false
					end					
				else
					if worm_pop >= worm_farm.pop_high then							
						n_meta:set_int("worm_dirt",worm_dirt+1+worm_farm.pop_high_b)
					else
						n_meta:set_int("worm_dirt",worm_dirt+1)							
					end						
				end			
			end
					
			-- next cycle check and start
			if inv:is_empty("worm_food") or not inv:room_for_item("output", worm_stack) then			
				n_meta:set_int("rep_cycle", 0)
				n_meta:set_int("time_cnt", 0)
				n_meta:set_string("formspec", worm_farm.worm_farm_form(pos))
				return false	
			
			else 
				-- find the location of our favorite worm food 
				-- inside worm_food inventory basically the item 
				-- with the lowest time in sec's
				local wf_size = inv:get_size("worm_food")
				local stack			
				local base_secs   = 10
				local pop_bonus   = 0
				local water_bonus = 0
				local time_secs   = 10
				local min_sec     = 9999
				
				for inv_loc = 1,wf_size,1 do
					local temp_stack = inv:get_stack("worm_food", inv_loc)
									
					if not temp_stack:is_empty() then
						local found, food_def = worm_farm.name_group(temp_stack:get_name())
						
						if found and food_def.sec < min_sec then					
							stack = temp_stack
							base_secs = food_def.sec
							min_sec = food_def.sec
						end
					end
				end
				
				-- Did we find any items worms can eat if not end
				if not stack then n_meta:set_int("rep_cycle", 0) return false end
				
				-- use food, not being specific in regards to inv position
				inv:remove_item("worm_food", stack:get_name().." 1")
				
				-- check if we have water			
				if water_level > 0 then
					water_bonus = worm_farm.water_bonus
					n_meta:set_int("water_level", water_level - worm_farm.water_use)
				end
				
				-- check for population bonus/penalty
				if worm_pop <= worm_farm.pop_crit then
					pop_bonus = -1 * worm_farm.pop_crit_b
				
				elseif worm_pop >= worm_farm.pop_med then
					pop_bonus = worm_farm.pop_med_b
					if worm_pop >= worm_farm.pop_high then
						pop_bonus = pop_bonus + worm_farm.pop_med_b
					end
				end 
				
				-- calculate our replication time for next cycle
				-- and start timer
				time_secs = base_secs - water_bonus - pop_bonus
				
				if time_secs < 1 then
					time_secs = 1
				end	
				n_meta:set_int("status",1)
				n_meta:set_int("rep_cycle", 1)
				n_meta:set_int("time_end",time_secs)
				n_meta:set_int("time_cnt",0)
				minetest.get_node_timer(pos):start(1.0)  -- redundant

				-- check and increase/decrease our population 
				if water_bonus ~= 0 and base_secs <= worm_farm.food_pop then					
					-- worm population increases by 5% each cycle 
					worm_pop = math.ceil(worm_pop+(worm_pop*0.05))
					
					if worm_pop > worm_farm.pop_max then
						worm_pop = worm_farm.pop_max
					end
					
					n_meta:set_int("worm_pop",worm_pop)
				
				elseif water_bonus <= 0 or base_secs > worm_farm.food_pop_d then
					-- no water, worm numbers decrease by 5% each cycle
					worm_pop = math.floor(worm_pop-(worm_pop*0.05))
					
					if worm_pop < worm_farm.pop_min then
						worm_pop = worm_farm.pop_min
					end				
					n_meta:set_int("worm_pop",worm_pop)					
				end			
			end				
		end
		
	else
		-- increment timer
		n_meta:set_int("time_cnt", time_cnt+1)	
	end
	-- update formspec
	n_meta:set_string("formspec", worm_farm.worm_farm_form(pos))
	return true	
end