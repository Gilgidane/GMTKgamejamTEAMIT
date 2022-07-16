extends KinematicBody2D

var player
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var enemy_level = rng.randf_range(1,5)
	
func _physics_process(delta):
	pass
