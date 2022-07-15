extends KinematicBody2D

var player

var velocity = Vector2.ZERO
export (int) var gravity = 2000

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var enemy_level = rng.randf_range(1,5)
	
func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x -= 10
