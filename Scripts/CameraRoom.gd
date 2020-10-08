extends Camera2D

export (NodePath) var _target = ""
export (Vector2) var _room_size = Vector2()

onready var _target_node = get_node(_target)

func get_target_pos() -> Vector2:
	var t_pos = _target_node.position
	var room_pos = Vector2()
	room_pos.x = floor(t_pos.x / _room_size.x)
	room_pos.y = floor(t_pos.y / _room_size.y)
	var room_center = room_pos * _room_size + 0.5 * _room_size
	return room_center

func _ready():
	position = get_target_pos()
	return

func _process(delta: float):
	position = get_target_pos()
	return
