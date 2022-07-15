extends KinematicBody2D

#exporting a var makes it editable from the right side panel
export (int) var speed = 400
export (int) var jump_speed = -500
export (int) var gravity = 2000
export var friction = 0.2
export var acceleration = 0.25

var velocity = Vector2.ZERO

func get_input():
	# As described, getting input. To check input map go to Project>Project Settings>Input Map
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)


func _physics_process(delta):
	# physics process executes on each computer tick - bound to framerate
	# here we get input, set the vertical velocity at gravity times delta
	# then if the jump input is pressed, we increase our vertical speed by jump_speed if we're 'on the floor'
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
