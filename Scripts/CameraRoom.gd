extends Camera2D

export (NodePath) var target = ""
export (Vector2) var room_size = Vector2()

var target_node = null

func get_target_pos():
	var t_pos = target_node.position
	var room_pos = Vector2()
	room_pos.x = floor(t_pos.x / room_size.x)
	room_pos.y = floor(t_pos.y / room_size.y)
	var room_center = room_pos * room_size + 0.5 * room_size
	return room_center

func _ready():
	target_node = get_node(target)
	position = get_target_pos()
	return

func _process(delta):
	position = get_target_pos()
	return
