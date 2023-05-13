Config = {}
Config.Locale = 'en'

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 0.5, y = 0.5, z = 0.5}
Config.MarkerColor  = {r = 000, g = 250, b = 154}
Config.MarkerType   = 21

Config.Zones = {}

Config.Shops = {
  {x=-718.7168,   y=-147.84,		z=37.41},
 }

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
