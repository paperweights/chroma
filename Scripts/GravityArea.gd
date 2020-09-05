extends Area2D

enum GravityDirection {
	Up = 180,
	Down = 0,
	Left = 90,
	Right = 270
}

export (GravityDirection) var _gravity_direction = GravityDirection.Down


func _on_collision_enter(body):
	get_tree().call_group("Rotator", "gravitator_enter", body, _gravity_direction)
	return
