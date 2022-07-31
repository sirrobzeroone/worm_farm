--------------------------------------------------------------
--       _ _ _                  _____                       --
--      | | | |___ ___ _____   |   __|___ ___ _____         --
--      | | | | . |  _|     |  |   __|_.||  _|     |        --
--      |_____|___|_| |_|_|_|  |__|  |__||_| |_|_|_|        --
--------------------------------------------------------------
--                     Worm Farm                            --
--------------------------------------------------------------
--            Add worms as drop to dirt nodes               --
--------------------------------------------------------------
-- add worms as dirt drop

-- default mod dirt drops
if worm_farm.is_default then
	worm_farm.register_worm_drop("default:dirt", 40)
	worm_farm.register_worm_drop("default:dirt_with_grass", 40)
	worm_farm.register_worm_drop("default:dirt_with_rainforest_litter", 30)
	worm_farm.register_worm_drop("default:dirt_with_dry_grass", 55)
end


-- farming mod soil drops
if worm_farm.is_farming or worm_farm.is_farming_redo then
	worm_farm.register_worm_drop("farming:soil", 40)
	worm_farm.register_worm_drop("farming:soil_wet", 35)
	worm_farm.register_worm_drop("farming:dry_soil_wet", 55)			 
end

-- ethereal mod dirt drops
if worm_farm.is_ethereal then
	worm_farm.register_worm_drop("ethereal:bamboo_dirt", 40)
	worm_farm.register_worm_drop("ethereal:jungle_dirt", 30)
	worm_farm.register_worm_drop("ethereal:grove_dirt", 40)	
	worm_farm.register_worm_drop("ethereal:prairie_dirt", 40)
	worm_farm.register_worm_drop("ethereal:crystal_dirt", 45)
	worm_farm.register_worm_drop("ethereal:mushroom_dirt", 45)
	worm_farm.register_worm_drop("ethereal:gray_dirt", 55)	
end