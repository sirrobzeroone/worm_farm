--------------------------------------------------------------
--       _ _ _                  _____                       --
--      | | | |___ ___ _____   |   __|___ ___ _____         --
--      | | | | . |  _|     |  |   __|_.||  _|     |        --
--      |_____|___|_| |_|_|_|  |__|  |__||_| |_|_|_|        --
--------------------------------------------------------------
--                     Worm Farm                            --
--------------------------------------------------------------
--            Add worm food and hydrate items               --
--------------------------------------------------------------
---------------
-- Worm Food --
---------------
-- Lower seconds for food indicate worms like the food more 
-- very dense/fiberous, high acidic, high aromatic foods they tend to dislike.

if worm_farm.is_default then
	-- food
 -- worm_farm.register_worm_food_water(reg name, time in seconds) 
	worm_farm.register_worm_food_water("default:apple", 6)
	worm_farm.register_worm_food_water("default:papyrus", 6)
	worm_farm.register_worm_food_water("default:paper", 7)
	worm_farm.register_worm_food_water("default:book", 15)
	worm_farm.register_worm_food_water("default:book_written", 15)
	worm_farm.register_worm_food_water("group:flower", 6)
	worm_farm.register_worm_food_water("group:grass", 7)
	worm_farm.register_worm_food_water("group:leaves", 6)
	worm_farm.register_worm_food_water("group:mushroom", 8)
	worm_farm.register_worm_food_water("group:sapling", 8)
	
	-- water/hydrate
 -- worm_farm.register_worm_food_water(reg name, refill amount, reg name empty vessel, "w" to indicate water/hydrate) 
	worm_farm.register_worm_food_water("bucket:bucket_water", 400, "bucket:bucket_empty" , "w")
end

if worm_farm.is_ethereal then
	-- food
	worm_farm.register_worm_food_water("ethereal:golden_apple", 2)	
	worm_farm.register_worm_food_water("ethereal:banana", 6)
	worm_farm.register_worm_food_water("ethereal:lemon", 15)
	worm_farm.register_worm_food_water("ethereal:orange", 15)
	worm_farm.register_worm_food_water("ethereal:sushi_kappamaki", 5)
	worm_farm.register_worm_food_water("ethereal:olive", 8)
	
	-- water/hydrate
	worm_farm.register_worm_food_water("ethereal:lemonade", 100, "vessels:drinking_glass", "w")
end

if worm_farm.is_bucket_wooden then
	-- water/hydrate
	worm_farm.register_worm_food_water("bucket_wooden:bucket_water", 400, "bucket_wooden:bucket_empty", "w")
end

if worm_farm.is_farming then
	-- food
	worm_farm.register_worm_food_water("farming:wheat", 9)	
	worm_farm.register_worm_food_water("farming:bread", 8)
end

if worm_farm.is_farming_redo then
	--food
	worm_farm.register_worm_food_water("farming:apple_pie", 7)
	worm_farm.register_worm_food_water("farming:artichoke", 20)
	worm_farm.register_worm_food_water("farming:baked_potato", 6)
	worm_farm.register_worm_food_water("farming:bread", 8)
	worm_farm.register_worm_food_water("farming:bread_slice", 6)
	worm_farm.register_worm_food_water("farming:bread_multigrain", 8)
	worm_farm.register_worm_food_water("farming:barley", 9)
	worm_farm.register_worm_food_water("farming:beans", 6)
	worm_farm.register_worm_food_water("farming:beetroot", 7)
	worm_farm.register_worm_food_water("farming:blackberry", 5)
	worm_farm.register_worm_food_water("farming:blueberries", 5)
	worm_farm.register_worm_food_water("farming:cabbage", 4)
	worm_farm.register_worm_food_water("farming:carrot", 5)
	worm_farm.register_worm_food_water("farming:carrot_gold", 2)
	worm_farm.register_worm_food_water("farming:chili_pepper", 25)	
	worm_farm.register_worm_food_water("farming:cocoa_beans_raw", 6)
	worm_farm.register_worm_food_water("farming:cocoa_beans", 6)	
	worm_farm.register_worm_food_water("farming:chocolate_block", 5)
	worm_farm.register_worm_food_water("farming:chocolate_dark", 6)
	worm_farm.register_worm_food_water("farming:cookie", 7)
	worm_farm.register_worm_food_water("farming:coffee_beans", 4)	
	worm_farm.register_worm_food_water("farming:corn", 6)
	worm_farm.register_worm_food_water("farming:corn_cob", 5)	
	worm_farm.register_worm_food_water("farming:cucumber", 4)
	worm_farm.register_worm_food_water("farming:donut", 6)
	worm_farm.register_worm_food_water("farming:donut_chocolate", 6)
	worm_farm.register_worm_food_water("farming:donut_apple", 6)	
	worm_farm.register_worm_food_water("farming:garlic", 25)
	worm_farm.register_worm_food_water("farming:garlic_clove", 25)
	worm_farm.register_worm_food_water("farming:garlic_braid", 30)
	worm_farm.register_worm_food_water("farming:garlic_bread", 20)	
	worm_farm.register_worm_food_water("farming:grapes", 5)	
	worm_farm.register_worm_food_water("farming:hemp_leaf", 7)
	worm_farm.register_worm_food_water("farming:hemp_fibre", 9)	
	worm_farm.register_worm_food_water("farming:hemp_block", 15)
	worm_farm.register_worm_food_water("farming:jackolantern", 8)
	worm_farm.register_worm_food_water("farming:jaffa_cake", 9)
	worm_farm.register_worm_food_water("farming:lettuce", 4)
	worm_farm.register_worm_food_water("farming:mochi", 8)
	worm_farm.register_worm_food_water("farming:melon_slice", 4)
	worm_farm.register_worm_food_water("farming:melon_8", 8)
	worm_farm.register_worm_food_water("farming:mint_leaf", 6)
	worm_farm.register_worm_food_water("farming:oat", 9)
	worm_farm.register_worm_food_water("farming:onion", 15)
	worm_farm.register_worm_food_water("farming:pasta", 8)
	worm_farm.register_worm_food_water("farming:parsley", 6)	
	worm_farm.register_worm_food_water("farming:pea_pod", 6)	
	worm_farm.register_worm_food_water("farming:pepper", 7)  -- sweet bellpeppers
	worm_farm.register_worm_food_water("farming:pepper_yellow", 7)
	worm_farm.register_worm_food_water("farming:pepper_red"	, 7)
	worm_farm.register_worm_food_water("farming:pineapple"	, 15)
	worm_farm.register_worm_food_water("farming:pineapple_ring", 11)
	worm_farm.register_worm_food_water("farming:popcorn", 5)
	worm_farm.register_worm_food_water("farming:potato", 8)
	worm_farm.register_worm_food_water("farming:potato_salad", 5)
	worm_farm.register_worm_food_water("farming:pumpkin_slice", 7)
	worm_farm.register_worm_food_water("farming:pumpkin", 9)
	worm_farm.register_worm_food_water("farming:pumpkin_bread", 7)
	worm_farm.register_worm_food_water("farming:raspberries", 5)
	worm_farm.register_worm_food_water("farming:rhubarb", 11)
	worm_farm.register_worm_food_water("farming:rhubarb_pie", 7)	
	worm_farm.register_worm_food_water("farming:rice", 9)
	worm_farm.register_worm_food_water("farming:rice_bread", 8)
	worm_farm.register_worm_food_water("farming:rye", 9)
	worm_farm.register_worm_food_water("farming:spaghetti", 8)	
	worm_farm.register_worm_food_water("farming:soy_pod", 11)
	worm_farm.register_worm_food_water("farming:sunflower", 6)
	worm_farm.register_worm_food_water("farming:sunflower_bread", 8)
	worm_farm.register_worm_food_water("farming:toast", 7)
	worm_farm.register_worm_food_water("farming:toast_sandwich", 7)	
	worm_farm.register_worm_food_water("farming:tofu", 12)	
	worm_farm.register_worm_food_water("farming:tofu_cooked", 12)
	worm_farm.register_worm_food_water("farming:tomato", 7)
	worm_farm.register_worm_food_water("farming:vanilla", 11)
	worm_farm.register_worm_food_water("farming:wheat", 9)	
	worm_farm.register_worm_food_water("group:plant", 7)
	
	-- water/hydrate	
	worm_farm.register_worm_food_water("farming:glass_water", 100,"vessels:drinking_glass", "w")
	worm_farm.register_worm_food_water("farming:carrot_juice", 100,"vessels:drinking_glass", "w")
	worm_farm.register_worm_food_water("farming:cactus_juice", 100,"vessels:drinking_glass", "w")
	worm_farm.register_worm_food_water("farming:smoothie_berry", 100,"vessels:drinking_glass", "w")
	worm_farm.register_worm_food_water("farming:pineapple_juice", 100,"vessels:drinking_glass", "w")
end