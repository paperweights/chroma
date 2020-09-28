extends KinematicBody2D

export (float) var gravity_multiplier = 2

var x_velocity = Vector2()
var y_velocity = Vector2()
var gravity_scale = 9.8
var is_grounded = false

func grounded(normal: Vector2):
	return normal.round() == -global_transform.y.round()

func y_collide(collision: KinematicCollision2D):
	if collision == null:
		return
	# Reset jumps.
	y_velocity = Vector2()
	if grounded(collision.normal):
		is_grounded = true
		return
	return

func x_collide(collision: KinematicCollision2D):
	if collision == null:
		return
	x_velocity = Vector2()
	return

func gravity(delta: float, gravity_mod: float):
	return gravity_scale * gravity_mod * delta * global_transform.y

func _physics_process(delta):
	is_grounded = false
	#x_velocity = move(delta)
	x_collide(move_and_collide(x_velocity))
	y_velocity += gravity(delta, gravity_multiplier)
	y_collide(move_and_collide(y_velocity))
	return
