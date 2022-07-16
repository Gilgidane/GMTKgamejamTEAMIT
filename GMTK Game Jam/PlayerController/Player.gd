extends KinematicBody2D

#exporting a var makes it editable from the right side panel
export (int) var speed = 400
export (int) var jump_speed = -500
export (int) var gravity = 2000
export var friction = 0.2
export var acceleration = 0.25
export (PackedScene) var arrow

enum {
	MOVE
}

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var velocity = Vector2.ZERO
var stats = PlayerStats
var state = MOVE

func _physics_process(delta):
	facing()
	match state:
		MOVE:
			pass
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		if is_on_floor():
			animationState.travel("Run")
		else:
			animationState.travel("Jump")
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if is_on_floor():
			animationState.travel("Idle")
		else:
			animationState.travel("Jump")
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_pressed("jump"):
		animationState.travel("Jump")
		if is_on_floor():
			velocity.y = jump_speed
		
	if Input.is_action_just_pressed("attack"):
		attack()
		#animationState.travel("Attack")

func attack():
	var b = arrow.instance()
	owner.add_child(b)
	b.transform = $Origin.global_transform

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
	animationTree.set("parameters/Run/blend_position", facing)
	animationTree.set("parameters/Attack/blend_position", facing)
	animationTree.set("parameters/Jump/blend_position", facing)

func attack_animation_finished():
	pass
	#animationState.travel("Idle")
