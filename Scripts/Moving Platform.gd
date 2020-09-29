extends Node2D

export (float) var pause = 1
onready var waypoints = $Waypoints.get_children()
var current_waypoint = 0
var time_since_arrive = 0

func next_waypoint():
	current_waypoint += 1
	current_waypoint = current_waypoint % len(waypoints)
	$Platform.target = waypoints[current_waypoint].position
	return

func has_arrived():
	var waypoint_position = waypoints[current_waypoint].position
	var platform_position = $Platform.position
	return platform_position.distance_to(waypoint_position) == 0

func _ready():
	$Platform.position = waypoints[current_waypoint].position
	$Platform.target = waypoints[current_waypoint].position
	return

func _process(delta):
	if has_arrived():
		if time_since_arrive >= pause:
			time_since_arrive = 0
			next_waypoint()
		else:
			time_since_arrive += delta
	return
