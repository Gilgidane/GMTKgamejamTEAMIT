extends Area2D

signal leaving_level

func _physics_process(delta):
	rotation = rotation + 11

func _on_ExitDoor_body_entered(body):
	emit_signal("leaving_level")
