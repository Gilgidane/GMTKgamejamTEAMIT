extends Node

export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health
var coins = 0 setget set_coins

signal coins_updated
signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
		
func set_coins(value):
	coins = value
	emit_signal("coins_updated")


func _ready():
	self.health = max_health
