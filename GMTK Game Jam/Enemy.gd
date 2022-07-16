extends KinematicBody2D

var gravity = 10
var velocity = Vector2(0, 0)
var speed = 80 # pixels per second
var is_moving_left = true
var is_attacking = false
var count = 0
#var rng = RandomNumberGenerator.new()

func _ready():
	pass
	#rng.randomize()
	#var enemy_level = rng.randf_range(1,5)
	
func _physics_process(delta):
	if is_attacking and count != 80:
		count += 1
		return
		
	move_character()
	if (not $RayCast2D.is_colliding() and is_on_floor()) or is_on_wall():
		turn()

func move_character():
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	$AnimatedSprite.play("walk")
	
func turn():
	is_moving_left = !is_moving_left
	scale.x = -scale.x
	
func _on_PlayerDetector_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite.play("attack")
		count = 0
		is_attacking = true
