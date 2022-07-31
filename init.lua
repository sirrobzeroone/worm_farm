--------------------------------------------------------------
--       _ _ _                  _____                       --
--      | | | |___ ___ _____   |   __|___ ___ _____         --
--      | | | | . |  _|     |  |   __|_.||  _|     |        --
--      |_____|___|_| |_|_|_|  |__|  |__||_| |_|_|_|        --
--------------------------------------------------------------
--                     Worm Farm                            --
--------------------------------------------------------------
--     https://patorjk.com/software/taag - Rectangles       --
--------------------------------------------------------------
-----------------
-- Basic Setup --
-----------------
-- modname and path
local m_name = minetest.get_current_modname()
local m_path = minetest.get_modpath(m_name)

-- setup mod global table/sub tables
worm_farm = {}
worm_farm.nodes = {}
worm_farm.textures = {}
worm_farm.sounds = {}
worm_farm.worm_foods = {}
worm_farm.worm_foods.ind = {}
worm_farm.worm_foods.grp = {}
worm_farm.worm_hydrate = {}
worm_farm.worm_hydrate.ind = {}
worm_farm.worm_hydrate.grp = {}

-- worm farm settings
worm_farm.water_max = 400  -- storage max in farm
worm_farm.water_use =   1  -- water used to create 1 worm
worm_farm.water_bonus = 2  -- number of seconds removed for having water
worm_farm.worm_tea =  198  -- Number of worms produced to get 1x worm tea
worm_farm.dirt =      297  -- Number of worms produced to get 1x dirt
worm_farm.pop_crit  =  30  -- worm population density critical limit - less than or equal
worm_farm.pop_crit_b =  4  -- worm density critical time penalty
worm_farm.pop_med =   120  -- worm population density medium limit - greater than or equal
worm_farm.pop_med_b =   1  -- worm density medium time bonus
worm_farm.pop_high =  175  -- worm population density high limit - greater than or equal
worm_farm.pop_high_b =  1  -- worm density high output bonus worm, bonus tea/dirt count (player also gets medium bonus x2)
worm_farm.pop_max =   200  -- worm population density max
worm_farm.pop_min =     2  -- worm population density min
worm_farm.food_pop =   10  -- Any food with a value above this will prevent population growth (worms hate food)
worm_farm.food_pop_d = 20  -- Any food with a value above this will cause population to decline (toxic to worms)

-- translation
worm_farm.translate = minetest.get_translator(m_name)

-- conditional mods
worm_farm.is_default  = minetest.get_modpath("default")
worm_farm.is_ethereal = minetest.get_modpath("ethereal")
worm_farm.is_bonemeal = minetest.get_modpath("bonemeal")
worm_farm.is_vessels  = minetest.get_modpath("vessels")
worm_farm.is_farming  = minetest.get_modpath("farming")
worm_farm.is_bucket_wooden = minetest.get_modpath("bucket_wooden")

-- farming_redo check
if worm_farm.is_farming and farming.mod then
		worm_farm.is_farming_redo = minetest.get_modpath("farming")
		worm_farm.is_farming = nil
end

----------------------------
-- Int/Ext Resource Setup --
----------------------------
-- worm_farm internal fallbacks
	-- Nodes/Items
	worm_farm.nodes.worm = "worm_farm:worm"
	worm_farm.nodes.dirt = "mapgen_stone"
	worm_farm.nodes.soil = "group:crumbly"
	worm_farm.nodes.wood = "group:choppy"
	worm_farm.nodes.bottle = ""
	
	-- Textures
	worm_farm.textures.worm   = "worm_farm_worm.png"
	worm_farm.textures.dirt   = "worm_farm_dirt.png"
	worm_farm.textures.bottle = ""
	
	-- Sounds
	worm_farm.sounds.sound_wood = {}
	
-- external mod integration
if worm_farm.is_default then
	-- Nodes/Items
	worm_farm.nodes.dirt = "default:dirt"
	worm_farm.nodes.soil = "group:soil"
	worm_farm.nodes.wood = "group:wood"
	
	-- Textures
	worm_farm.textures.dirt   = "default_dirt.png"
	
	-- Sounds
	worm_farm.sounds.sound_wood = default.node_sound_wood_defaults()	
end

if worm_farm.is_vessels then
	-- Nodes/Items
	worm_farm.nodes.bottle = "vessels:glass_bottle"
	
	-- Textures
	worm_farm.textures.bottle = "vessels_glass_bottle.png"
	
end

if  worm_farm.is_ethereal then
	-- Nodes/Items
	worm_farm.nodes.worm = "ethereal:worm"
	
	--Textures
	worm_farm.textures.worm  = "ethereal_worm.png"
end

dofile(m_path .. "/i_functions.lua")
dofile(m_path .. "/i_add_worms_dirt.lua")
dofile(m_path .. "/i_add_worm_food_water.lua")
dofile(m_path .. "/i_nodes_items.lua")
