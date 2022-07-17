extends Area2D

export(PackedScene) var TargetScene

func _ready():
	pass 

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if get_overlapping_bodies().size() > 1:
			if !TargetScene:
				print("no scene in this door")
				return
			next_level()

func next_level():
	var ERR = get_tree().change_scene_to(TargetScene)
