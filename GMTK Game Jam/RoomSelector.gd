extends Node

export (Array, PackedScene) var scenes
var nextRoom = PackedScene

func _physics_process(delta):
	randomize()
	nextRoom = randi() % 3
