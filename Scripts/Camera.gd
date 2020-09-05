extends Camera2D

export (NodePath) var target = ""

var target_node = null
var rot = null

func _ready():
	target_node = get_node(target)
	rot = target_node.rotation_degrees
	rotation_degrees = rot

func _process(delta):
	position = target_node.position
	rot = lerp(rot, target_node.rotation_degrees, delta)
	rotation_degrees = rot
	return
