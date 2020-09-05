extends Node2D

enum GravityDirection {
	Up = 180,
	Down = 0,
	Left = 90,
	Right = 270
}

export (GravityDirection) var _gravity_direction = GravityDirection.Down

func set_gravity_direction(gravity_direction):
	_gravity_direction = gravity_direction
	get_child(0).rotation_degrees = _gravity_direction
	return

func _ready():
	set_gravity_direction(_gravity_direction)
	return


func gravitator_enter(body, gravity_direction):
	if body != get_child(0):
		return
	set_gravity_direction(gravity_direction)
	return
