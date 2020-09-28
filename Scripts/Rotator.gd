extends Node2D

enum GravityDirection {
	Up = 180,
	Down = 0,
	Left = 90,
	Right = 270
}

export (NodePath) var _target = ""
export (GravityDirection) var _gravity_direction = GravityDirection.Down

var _target_node = null

func set_gravity_direction(gravity_direction):
	_gravity_direction = gravity_direction
	_target_node.rotation_degrees = _gravity_direction
	return

func _ready():
	_target_node = get_node(_target)
	set_gravity_direction(_gravity_direction)
	return


func gravitator_enter(body, gravity_direction):
	if body != _target_node:
		return
	set_gravity_direction(gravity_direction)
	return
