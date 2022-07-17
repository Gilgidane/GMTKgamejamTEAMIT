extends KinematicBody2D

export var GRAVITY = 2000

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity,Vector2.UP)

