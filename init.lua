potions = {}



function potions.register_potion(iname, color, exptime, action, expaction)
	iname = string.gsub(iname, "[-%[%]()1023456789 ]", "")
	minetest.register_craftitem("potions:"..iname, {
		description = iname.." Potion",
		inventory_image = "potions_bottle.png^potions_"..color..".png",

		on_place = function(itemstack, user, pointed_thing)
			action(itemstack, user, pointed_thing)
  			 minetest.after(exptime, expaction, itemstack, user, pointed_thing)
			itemstack:take_item()
			--Particle Code
			local vel = {x=math.random(-1, 1), y= 2, z=math.random(-1, 1)}
			local acc = {x=0, y=0.2, z=0}
			minetest.add_particlespawner(20, 0.5,
   		 user:getpos(), user:getpos(),
   		 {x=2, y= 2, z=2}, {x=-2, y= 2, z=-2},
   		 acc, acc,
   		 50, 100,
   		 1, 3,
  			 false, "potions_particle.png")
			return itemstack
			
		end,
	})
end

minetest.register_craft({
	output = 'potions:cauldron',
	recipe = {
		{'', '', ''},
		{'default:steel_ingot', 'default:mese_crystal', 'default:steel_ingot'},
		{'default:mese_crystal', 'default:steel_ingot', 'default:mese_crystal'},
	}
})


potions.register_potion("Anti Gravity", "purple", 5,
function(itemstack, user, pointed_thing) 
	user:set_physics_override(3, 1.5, 0.5)
	minetest.chat_send_player(user:get_player_name(), "You have been blessed with Anti Gravity for 60 seconds!")
end,

function(itemstack, user, pointed_thing)
	user:set_physics_override(1,1,1)
	minetest.chat_send_player(user:get_player_name(), "Anti Gravity has worn off.")
end)
