extends KinematicBody2D

export(PackedScene) var object_scene = null

const COIN = preload("res://Main/Coin.tscn")
const HEART = preload("res://HeartPickup.tscn")
const BAT = preload("res://Main/Bat.tscn")
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
	rng.randomize()
	var loot_roll = rng.randf_range(1,100)
	print(loot_roll)
	if loot_roll <= 20:
		spawn_bats()
	elif loot_roll <= 60:
		spawn_hearts()
	elif loot_roll <= 100:
		spawn_coins()
	
func spawn_bats():
	var amount = rng.randi_range(3,5)
	print(amount)
	for i in range(1, amount+1):
		var bat = BAT.instance()
		rng.randomize()
		var bat_x = rng.randi_range(1,30)-15
		var bat_y = rng.randi_range(1,40)-60
		
		bat.position = Vector2(chest.position[0] + bat_x, chest.position[1] + bat_y)
		get_tree().get_root().add_child(bat)
	
func spawn_hearts():
	var heart_amount = rng.randi_range(3,4)
	print(heart_amount)
	for i in range(1, heart_amount+1):
		rng.randomize()		
		var heart = HEART.instance()
		var heart_x = rng.randi_range(1,10)-5
		var heart_y = rng.randi_range(1,10)-50
		
		heart.position = Vector2(chest.position[0] + heart_x, chest.position[1] + heart_y)
		get_tree().get_root().add_child(heart)
	
func spawn_coins():
	var coin_amount = rng.randi_range(3,6)
	print(coin_amount)
	for i in range(1, coin_amount+1):
		rng.randomize()
		var coin = COIN.instance()
		var coin_x = rng.randi_range(1,10)-5
		var coin_y = rng.randi_range(1,10)-50
		
		coin.position = Vector2(chest.position[0] + coin_x, chest.position[1] + coin_y)
		get_tree().get_root().add_child(coin)
		
