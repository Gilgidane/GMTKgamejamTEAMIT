extends Node2D

const Exit = preload("res://Main/ExitDoor.tscn")
const Bat = preload("res://Main/Bat.tscn")
const Slime = preload("res://Main/Slime.tscn")
const GroundSpike = preload("res://Main/Spikes.tscn")

var borders = Rect2(1, 1, 700, 500) #potential generation size
var roomStore = []

onready var tileMap = $TileMap
onready var player = $Player

func _ready():
	randomize()
	generate_level()
	
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
	exit.connect("leaving_level", self, "reload_level")
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
		else:
			pass
		current_room = current_room + 1

func reload_level():
	get_tree().reload_current_scene()

func reroll():
	get_tree().reload_current_scene()
