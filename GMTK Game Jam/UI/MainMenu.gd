extends Control

func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://Main.tscn") 
	get_tree().paused = false

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
