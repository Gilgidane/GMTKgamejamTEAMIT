extends Area2D

signal leaving_level

onready var sprite = $AnimatedSprite

func _physics_process(delta):
	sprite.rotation = sprite.rotation + 11

func _on_ExitDoor_body_entered(body):
	emit_signal("leaving_level")
