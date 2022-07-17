extends KinematicBody2D

const GRAVITY = 1000

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
