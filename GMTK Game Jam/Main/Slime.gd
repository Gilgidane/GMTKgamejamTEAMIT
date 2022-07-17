extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var GRAVITY = 2000

enum{
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var state = IDLE

onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	match state:
		IDLE:
			velocity.x = lerp(velocity.x, 0, FRICTION)
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
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity,Vector2.UP)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	queue_free()
