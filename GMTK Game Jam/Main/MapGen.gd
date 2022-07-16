extends TileMap

export var width = 100
export var height = 28
var openSimplexNoise = OpenSimplexNoise.new()

func _ready():
	randomize()
	openSimplexNoise.seed = randi()
	openSimplexNoise.octaves = 2
	openSimplexNoise.persistence = 50
	openSimplexNoise.lacunarity = 4
	generate_map()

func generate_map():
	for x in width:
		for y in height:
			var rand = floor((abs(openSimplexNoise.get_noise_2d(x,y)))*10)
			self.set_cell(x,y,rand)

