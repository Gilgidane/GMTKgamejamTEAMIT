extends Node2D

const Next_Level = preload("res://Main/Mountain.tscn")
const Exit = preload("res://Main/ExitDoor.tscn")
const Bat = preload("res://Main/Bat.tscn")
const Slime = preload("res://Main/Slime.tscn")
const GroundSpike = preload("res://Main/Spikes.tscn")
const Torch = preload("res://Resources/Torch.tscn")
const Chest = preload("res://Main/LootChest.tscn")

var borders = Rect2(1, 1, 700, 500) #potential generation size
var roomStore = []
var stats = PlayerStats

onready var tileMap = $TileMap
onready var player = $Player

func _ready():
	randomize()
	generate_level()
	print(stats.level_count)


func _physics_process(delta):

	if Input.is_action_pressed("reroll"):
		reroll()

func generate_level():
	var walker = Walker.new(Vector2(40, 12), borders) #create walker, set start position
	var map = walker.walk(randi() % 700 + 100)
	player.position = map.front()*32
	var exit = Exit.instance() #create the exit
	add_child(exit)
	exit.position = walker.get_end_room().position*32
	exit.collision_mask = 1
	exit.connect("leaving_level", self, "update_level_count")
	roomStore = walker.rooms #store the room array here
	walker.queue_free() #kill the walker
	
	var roomNo = 10
	for location in map:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)
	
	var current_room = 0
	while current_room <= len(roomStore)-1:
		var chance = randi() % 1000
		if !current_room <= 4:
			if chance <= 20:
				var bat = Bat.instance()
				add_child(bat)
				bat.position.x = roomStore[current_room].position.x*32
				bat.position.y = roomStore[current_room].position.y*32
			elif chance <= 30:
				var slime = Slime.instance()
				add_child(slime)
				slime.position.x = roomStore[current_room].position.x*32
				slime.position.y = roomStore[current_room].position.y*32
			elif chance <= 40:
				var groundSpike = GroundSpike.instance()
				add_child(groundSpike)
				groundSpike.position.x = roomStore[current_room].position.x*32
				groundSpike.position.y = roomStore[current_room].position.y*32
			elif chance <= 50:
				var torch = Torch.instance()
				add_child(torch)
				torch.position.x = roomStore[current_room].position.x*32
				torch.position.y = roomStore[current_room].position.y*32 
			elif chance <= 60:
				var chest = Chest.instance()
				add_child(chest)
				chest.position.x = roomStore[current_room].position.x*32
				chest.position.y = roomStore[current_room].position.y*32 
		else:
			pass
		current_room = current_room + 1

func update_level_count():
	stats.level_count += 1
	if stats.level_count >= 3:
		stats.level_count = 0
		get_tree().change_scene_to(Next_Level)
	else:
		get_tree().reload_current_scene()


func change_level():
	pass
func reroll():
	get_tree().reload_current_scene()
