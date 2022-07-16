extends Position2D


func _physics_process(delta):
	var target = get_global_mouse_position()
	look_at(target)
