potions = {}



function potions.register_potion(iname, color, exptime, action, expaction)
	iname = string.gsub(iname, "[-%[%]()1023456789 ]", "")
	minetest.register_craftitem(minetest.get_current_modname()..":"..iname:lower(), {
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


