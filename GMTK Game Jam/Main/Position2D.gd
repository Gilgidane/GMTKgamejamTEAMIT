extends Node2D

export (Array, PackedScene) var scenes

func _ready():
	randomize()
	var x = randi() % scenes.size()
	var scene = scenes[x].instance()
	add_child(scene)
