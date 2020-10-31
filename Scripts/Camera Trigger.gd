extends Area2D

export (NodePath) var _player_node = ""
export (Vector2) var _min_room = Vector2()
export (Vector2) var _max_room = Vector2()

onready var _player = get_node(_player_node)

func _on_Camera_Trigger_body_entered(body):
	if body != _player:
		return
	get_tree().call_group("Camera", "update_room_size", _min_room, _max_room)
	return
