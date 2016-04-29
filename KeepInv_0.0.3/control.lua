require "defines"
require "util"



script.on_event(defines.events.on_tick, function(event)
	
	if global.table_loaded==nil and game.players~=nil then
	global.invlist={}
	global.plydead={} 
	global.table_loaded=true
	end
	
	if (game.tick % 120) == 10 then
	list_inv()
	end
	
end)



function list_inv()
		local plyr
		if game.players ~= nil then
		for k,plyr in pairs(game.players) do
			if plyr.valid and plyr.connected then
				
				if plyr.character == nil then
					global.plydead[k] = true
				end
				if global.plydead ~= nil then
					if global.plydead[k]==true and plyr.character ~= nil then
						for item_name,item_count in pairs(global.invlist[k]) do
							plyr.get_inventory(defines.inventory.chest).insert{name=item_name, count=item_count}
						end
						global.plydead[k] = false
			
					else if plyr.character ~= nil and plyr.name ~= nil then
						global.invlist[k]=plyr.get_inventory(defines.inventory.chest).get_contents()
					end
				end
			end
			end
		end
	end
end
