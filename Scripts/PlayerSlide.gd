extends KinematicBody2D

export (float) var speed = 60
export (float) var jump_height = 130
export (float) var normal_gravity = 2
export (float) var hold_gravity = 0.5

onready var sprite = $AnimatedSprite

var input = Vector2()
var x_velocity = Vector2()
var y_velocity = Vector2()
var snap = Vector2()
var jump_held = false
var jump_pressed = false
var is_jumping = true
var gravity_scale = 9.8

func _physics_process(delta):
	_get_input()
	# Horizontal movement.
	x_velocity = _move()
	# Vertical movement.
	y_velocity += _gravity(_get_gravity_mod())
	_jump()
	# Calculating movement.
	y_velocity = global_transform.y * move_and_slide_with_snap(x_velocity + y_velocity, snap, Vector2.UP)
	_check_jumping()
	# Draw.
	sprite.flip_sprite(_get_x_vel())
	return

func _get_input():
	input = Vector2()
	# Jumping.
	jump_held = Input.is_action_pressed("player_jump")
	jump_pressed = Input.is_action_just_pressed("player_jump")
	# Walking.
	input.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	input.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	return

func _move():
	return input * speed * global_transform.x.abs()

func _gravity(gravity_mod: float):
	return gravity_scale * gravity_mod * global_transform.y

func _get_gravity_mod():
	if _get_y_vel() < 0:
		if jump_held:
			return hold_gravity
		return normal_gravity
	return 1

func _jump():
	if !jump_pressed:
		return
	is_jumping = true
	y_velocity = -jump_height * global_transform.y
	return

func _update_snap():
	snap = Vector2(0,4) if !is_jumping else Vector2()
	return

func _check_jumping():
	if is_jumping &&  _get_y_vel() > 0:
		is_jumping = false
	return

func _get_y_vel():
	var y_vel = y_velocity * global_transform.y
	return y_vel.x + y_vel.y

func _get_x_vel():
	var x_vel = x_velocity * global_transform.x
	return x_vel.x + x_vel.y
