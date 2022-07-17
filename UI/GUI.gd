extends Control


onready var game_overlay = get_node("Game_Overlay")


# Called when the node enters the scene tree for the first time.
func _ready():
	show_hud()

func show_hud():
	game_overlay.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
