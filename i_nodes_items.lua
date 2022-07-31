--------------------------------------------------------------
--       _ _ _                  _____                       --
--      | | | |___ ___ _____   |   __|___ ___ _____         --
--      | | | | . |  _|     |  |   __|_.||  _|     |        --
--      |_____|___|_| |_|_|_|  |__|  |__||_| |_|_|_|        --
--------------------------------------------------------------
--                     Worm Farm                            --
--------------------------------------------------------------
--            Register Nodes, Items and Recipes             --
--------------------------------------------------------------

-- translation
local S = worm_farm.translate

-- deregister ethereal worm recipe
if worm_farm.is_ethereal then
	minetest.clear_craft({
		output = "ethereal:worm",
		recipe = {
			{"default:dirt","default:dirt"}
		}
	})
end

-- Register recipe
minetest.register_craft({
	output = "worm_farm:worm_farm",
	recipe = {
		{worm_farm.nodes.wood,worm_farm.nodes.wood,worm_farm.nodes.wood},
		{worm_farm.nodes.worm,worm_farm.nodes.soil,worm_farm.nodes.worm},
		{worm_farm.nodes.wood,worm_farm.nodes.wood,worm_farm.nodes.wood}
	}
})


-- Register Node
minetest.register_node("worm_farm:worm_farm", {
	description = S("Worm Farm"),
	drawtype = "normal",
	paramtype2 = "facedir",
	tiles = {"worm_farm_farm_top.png", 
			 "worm_farm_farm_bottom.png",
			 "worm_farm_farm_side.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 3},
	sounds = worm_farm.sounds.sound_wood,
	after_place_node = function(pos, placer)
		local n_meta = minetest.get_meta(pos)		
		n_meta:set_string("infotext", S("Worm Farm"))
		n_meta:set_string("formspec", worm_farm.worm_farm_form(pos))
		n_meta:set_int("rep_cycle",0)
		n_meta:set_int("time_end",0)
		n_meta:set_int("time_cnt",0)
		n_meta:set_int("water_level",0)
		n_meta:set_int("worm_tea",0)
		n_meta:set_int("worm_dirt",0)
		n_meta:set_int("worm_pop",2)

		local inv = n_meta:get_inventory()
		inv:set_size("worm_food", 3)
		inv:set_size("empty_bottle",1)
		inv:set_size("output",6)
	end,
	
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)			
		local n_meta = minetest.get_meta(pos);		
		-- this is(maybe was)the offical way to close node formspec - blank it
		-- https://github.com/minetest/minetest/pull/4675#issuecomment-257179262
		-- still results in a flicker of the underlying formspec before blanking.
		n_meta:set_string("formspec", "")
		
		-- Adding water check
		local is_water, water_def = worm_farm.name_group(itemstack:get_name(),"w")
		if is_water then				
			cur_water_level = n_meta:get_int("water_level")
			add_water       = water_def.water			
			new_water_level = cur_water_level + add_water
			
			if new_water_level > worm_farm.water_max then
				new_water_level = worm_farm.water_max
			end
			
			-- I had some issues with set_wielded_item and items that stack
			-- even inv:set_stack had similar issue not sure if bug or me?
			local s_max = itemstack:get_stack_max()
			itemstack:take_item()	
			
			if s_max == 1 then 				
				player:set_wielded_item(water_def.empty.." 1")
				
			else 
				local inv = player:get_inventory()
				
				if inv:room_for_item("main", water_def.empty.." 1") then
					inv:add_item("main", water_def.empty.." 1")						
				else
					minetest.item_drop(water_def.empty.." 1", player, player:get_pos())				
				end				
			end
			
			n_meta:set_int("water_level",new_water_level)
			
			-- restore the formspec - if it's not done here there 
			-- can be an empty click when next clicking without water item
			minetest.after(0.2, function() 
				n_meta:set_string("formspec", worm_farm.worm_farm_form(pos))
			end)
			
		else
			n_meta:set_string("formspec", worm_farm.worm_farm_form(pos))
		end
	end,

	on_receive_fields = function(pos, formname, fields, sender)
	end,
	
	on_timer = worm_farm.timer_replicate,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname == "output" then
			return 0
			
		elseif listname == "empty_bottle" then
			if stack:get_name() == worm_farm.nodes.bottle then
				return stack:get_count()
			else
				return 0			
			end
			
		elseif listname == "worm_food" then		
			if worm_farm.name_group(stack:get_name()) then		
				return stack:get_count()
			else
				return 0
			end
		end
	end,

	on_metadata_inventory_put = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,

	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)		
	end,

	on_metadata_inventory_take = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	
	can_dig = function(pos, player)
		local n_meta = minetest.get_meta(pos);
		local inv = n_meta:get_inventory()
		return inv:is_empty("worm_food") and inv:is_empty("output") and inv:is_empty("empty_bottle")
	end
})


-- Register Worm Tea Concentrate - made this strength 4 its very strong irl
if worm_farm.is_bonemeal and worm_farm.is_vessels then
	minetest.register_craftitem("worm_farm:worm_tea", {
	description = S("Worm Tea Concentrate"),
	inventory_image = "worm_farm_worm_tea.png",

	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
			return
		end

		if bonemeal:on_use(pointed_thing.under, 4) then
			if not bonemeal.is_creative(user:get_player_name()) then
				itemstack:take_item()
				
				local inv = user:get_inventory()
				if inv:room_for_item("main", worm_farm.nodes.bottle.." 1") then
						inv:add_item("main", worm_farm.nodes.bottle.." 1")					
				else
					minetest.item_drop(worm_farm.nodes.bottle.." 1", user, user:get_pos())				
				end				
			end
		end
		return itemstack
	end
	})
end	 