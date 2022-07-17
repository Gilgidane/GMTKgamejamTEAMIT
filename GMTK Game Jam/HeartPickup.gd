extends RigidBody2D

export(PackedScene) var object_scene = null

const HEART_TIMER = 10

var time = 0
onready var heart = self

func _ready() -> void:
	$AnimatedSprite.play("idle")
	
func _physics_process(delta):
	time += delta
	if time > HEART_TIMER:
		time = 0
		heart.queue_free()
		
func _on_PlayerDetection_body_entered(body):
	if body.name == "Player":
		PlayerStats.health += 1
		heart.queue_free()
