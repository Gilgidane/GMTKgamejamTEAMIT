extends KinematicBody2D

export(PackedScene) var object_scene = null

const COIN = preload("res://Main/Coin.tscn")
onready var chest = self

var is_player_overlap: bool = false
var is_opened: bool = false
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	$AnimatedSprite.play("idle")
	
func _physics_process(delta):
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and is_player_overlap and not is_opened:
		open_chest()
		
func _on_PlayerDetection_body_entered(body):
	if body.name == "Player":
		if $AnimatedSprite.animation == "idle":
			$AnimatedSprite.play("press_e")
		is_player_overlap = true
	
func _on_PlayerDetection_body_exited(body):
	if body.name == "Player":
		if $AnimatedSprite.animation == "press_e":
			$AnimatedSprite.play("idle")
		is_player_overlap = false
		
func open_chest():
	is_opened = true
	$AnimatedSprite.play("open")
	roll_loot_table()
	
func roll_loot_table():
	#var loot_roll = rng.randf_range(1,100)
	#if loot_roll <= 20:
	#	print("BAT")
	#elif loot_roll <= 40:
	#	print("COINS")
	#	spawn_coins()
	#elif loot_roll <= 60:
	#	print("HEARTS")
	#elif loot_roll <= 80:
	#	print("DICE")
	#else:
	#	print("JACKPOT")
	spawn_coins()	
	
func spawn_coins():
	var coin_amount = rng.randi_range(3,5)
	print(coin_amount)
	for i in range(1, coin_amount+1):
		var coin = COIN.instance()
		var coin_x = rng.randi_range(1,10)-5
		var coin_y = rng.randi_range(1,10)-50
		
		coin.position = Vector2(chest.position[0] + coin_x, chest.position[1] + coin_y)
		get_tree().get_root().add_child(coin)
	
