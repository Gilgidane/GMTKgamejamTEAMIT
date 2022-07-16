extends Position2D


func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	position = mouse_pos
