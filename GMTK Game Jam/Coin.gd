extends RigidBody2D

export(PackedScene) var object_scene = null

const COIN_TIMER = 10

var time = 0
onready var coin = self

func _ready() -> void:
	$AnimatedSprite.play("idle")
	
func _physics_process(delta):
	time += delta
	if time > COIN_TIMER:
		time = 0
		coin.queue_free()
		
func _on_PlayerDetection_body_entered(body):
	if body.name == "Player":
		PlayerStats.coins += 1
		coin.queue_free()
