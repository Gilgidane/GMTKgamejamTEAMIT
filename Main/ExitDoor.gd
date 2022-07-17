extends Area2D

signal leaving_level

onready var sprite = $AnimatedSprite

var stats = PlayerStats

func _physics_process(delta):
	sprite.rotation = sprite.rotation + 11

func _on_ExitDoor_body_entered(body):
	stats.level_count += 1
	emit_signal("leaving_level")
	
