extends AnimatedSprite

export(PackedScene) var object_scene = null

var is_player_overlap: bool = false
var is_opened: bool = false

#onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var tween: Tween = get_node("Tween")

func _ready() -> void:
	pass
	#assert(object_scene != null)
	#animation_player.play("idle")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and is_player_overlap and not is_opened:
		is_opened = true
		#animation_player.play("open")

func drop_object() -> void:
	pass
