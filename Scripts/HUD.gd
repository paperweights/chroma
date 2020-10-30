extends Node2D

func _process(delta):
	_get_input()
	return

func _get_input():
	# Toggle visibility.
	if (Input.is_action_just_pressed("ui_cancel")):
		_toggle_visibility()
	return

func _toggle_visibility():
	visible = !visible
	Engine.time_scale = 0 if visible else 1
	return
