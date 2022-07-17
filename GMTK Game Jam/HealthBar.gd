extends Node2D

var bar_red = preload("res://Red.png")
var bar_green = preload("res://Green.png")
var bar_yellow = preload("res://Yellow.png")

onready var healthbar = $HealthTexture
onready var tween = $Tween

func _ready():
	show()
	if get_parent() and get_parent().get("max_health"):
		healthbar.max_value = get_parent().max_health
		healthbar.value = get_parent().max_health

func _process(delta):
	global_rotation = 0

func update_healthbar(value):
	healthbar.value = value
	#tween.interpolate_property(healthbar, "value", healthbar.value, hp, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	#tween.start()

	healthbar.texture_progress = bar_green
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	if value < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	if value < healthbar.max_value:
		healthbar.value = value
