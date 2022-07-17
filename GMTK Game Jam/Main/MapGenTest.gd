extends Node2D

const Player = preload("res://PlayerController/Player.tscn")
const Exit = preload("res://Main/ExitDoor.tscn")
var borders = Rect2(1, 1, 142, 78)

onready var tileMap = $TileMap

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(40, 12), borders)
	var map = walker.walk(randi() % 1200 + 100)
	
	var player = Player.instance()
	add_child(player)
	player.position = map.front()*32
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position*32
	exit.connect("leaving_level", self, "reload_level")
	
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

func reload_level():
	get_tree().reload_current_scene()
