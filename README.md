# Worm Farm

Thanks to Tenplus1 for his excellent Ethereal mod and Xanadu server, without those two this mod wouldn't exist.

Simple mod although hopefully fairly feature rich. Adds a Worm Farm to Minetest which can accept most green waste material which the worms will eat and use to reproduce and create more worms which you can then use for fishing. The worms will also produce worm tea (if bonemeal mod and vessels mod are active) and dirt although slowly. 

The mod is primarily aimed to be used with Ethereal mod's fishing however I have made it fairly easy to configure if you wish to use it with another game or if theres another fishing mod let me know and I'll add support for it.

## Overview
The Worms in the worm farm are very self-contained and so long as you keep feeding them something they will produce worms for use when fishing. However if you:

 - Keep the Worm Farm Hydrated and
 - Feed them foods they like 

They will produce worms for fishing faster and the population of worms inside the Worm farm will grow, which will also produce worms faster and allow them to eat food faster. Although not a direct simulation of a real life worm farm the worms do like and dislike similar foods to there real life cousins. For example they will rapidly devour melon slices and dislike anything with garlic immensly. The worms in the worm farm will also eat their more favorite foods first.

## API functions

### Register Worm Food/Water
worm_farm.register_worm_food_water(thing_name, amount, return_empty, type)

####  Register Worm Food
Registering a worm food only makes use of the first two fields in the function. The lower the time in seconds the more the worms like the food. It is recommended the lowest you go for their most favorite foods is 4 (seconds). If the defaults are not changed once you exceed 10 secs worm farm population wont increase when they eat that food. Once 20 secs is exceeded the worm population will decline when they eat that food as it i semi-toxic/takes to long for them to eat.

Nodes or items can be registered worms will eat both
example (only provide 1st two values):
 worm_farm.register_worm_food_water("default:paper", 7 )

Worms can eat paper and it will take them 7 seconds to eat a single piece if no bonus's or penalties are being applied. Once they finish eating a worm will be avaliable to collect and use for baiting fishing hooks.

#### Register Worm Water
The worm farm needs to be kept moist to keep the worms happy. Additional items can be registered that hydrate/add water to the farm. If not changed the maximum water storage for the farm is 400 units. A bucket of water will hydrate the farm completely where as a glass of carrot juice from farmign redo only adds 100 units of hydration.

Nodes or items can be registered
example (provide all four values):
worm_farm.register_worm_food_water("bucket:bucket_water", 400, "bucket:bucket_empty" , "w")

When the worm farm is right clicked with a bucket of water, it will be filled with 400 units of water/hydration. The player will get an empty bucket back. The "w" flag is so the function knows this is a water registration - bit redundant as I could just check for empty item value, future update maybe.

### Register Worm as drop from Nodes
worm_farm.register_worm_drop(node_name, rarity)

Lets you register worms as another drop from a node. This wont disturb the existing nodes drops and will increase the max node drops by +1 basically the worms drop for free. The worms will be inserted in the correct order into the node drop table.

example:
worm_farm.register_worm_drop("default:dirt", 40)

The default dirt nodes drop would now look like this - assuming ethereal is active:

    drop = {
		max_items = 2,
		items = {
			{
				rarity = 40,
				items = {
					"ethereal:worm"
				}
			},
			{
				items = {
					"default:dirt"
				}
			}
		}
	}


