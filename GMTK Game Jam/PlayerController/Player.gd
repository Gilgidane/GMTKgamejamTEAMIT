extends KinematicBody2D

#exporting a var makes it editable from the right side panel
export (int) var speed = 400
export (int) var jump_speed = -500
export (int) var gravity = 2000
export var friction = 0.2
export var acceleration = 0.25

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

enum{
	MOVE,
	ATTACK
}

var velocity = Vector2.ZERO
var state = MOVE

func _physics_process(delta):
	# physics process executes on each computer tick - bound to framerate
	# here we get input, set the vertical velocity at gravity times delta
	# then if the jump input is pressed, we increase our vertical speed by jump_speed if we're 'on the floor'
	facing()
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state()

	velocity = move_and_slide(velocity, Vector2.UP)


func move_state(delta):
	# As described, getting input. To check input map go to Project>Project Settings>Input Map
	facing()
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	velocity.y += gravity * delta
	
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
		
	if Input.is_action_just_pressed("attack"):
		if is_on_floor():
			state = ATTACK

func attack_state():
	animationState.travel("Attack")


func facing():
	var mousePos = get_global_mouse_position()
	var playerPos = get_global_position()
	var facing = Vector2.ZERO
	if mousePos.x == playerPos.x:
		facing.x = 0
	elif mousePos.x + 10 < playerPos.x:
		facing.x = -1
	elif mousePos.x + 10 > playerPos.x:
		facing.x = 1
	facing = facing.normalized()
	animationTree.set("parameters/Idle/blend_position", facing)
	animationTree.set("parameters/Attack/blend_position", facing)

func attack_animation_finished():
	velocity.y = lerp(velocity.y, 0, friction)
	animationState.travel("Idle")
	state = MOVE
