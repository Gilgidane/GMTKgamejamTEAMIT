extends KinematicBody2D

const HP_BAR = preload("res://HealthBar.tscn")
onready var bat_instance = self

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
var max_health = 10
var current_health = max_health

enum{
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var state = IDLE

onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $AnimatedSprite

func _ready():
	$HealthBar.scale = Vector2(0.05, 0.05)
	#$HealthBar.position = Vector2(bat_instance.position[0], bat_instance.position[1])

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	current_health -= 1
	$HealthBar.update_healthbar(current_health)
	if current_health <= 0:
		queue_free()
