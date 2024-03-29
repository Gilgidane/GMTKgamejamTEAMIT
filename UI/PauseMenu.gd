extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_ResumeButton_pressed() -> void:
	self.is_paused = false


func _on_QuitButton_pressed() -> void:
	get_tree().quit()



func _on_ExitToMenuButton_pressed() -> void:
	get_tree().change_scene("res://UI/MainMenu.tscn")
