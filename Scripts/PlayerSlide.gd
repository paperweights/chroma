extends KinematicBody2D

export (float) var speed = 60
export (float) var jump_height = 130

var input = Vector2()
var velocity = Vector2()
var jump_held = false
var jump_pressed = false
var is_jumping = true
var gravity_scale = 9.8

func _physics_process(delta):
	_get_input()
	# Horizontal movement.
	velocity.x = input.x * speed
	# Vertical movement.
	velocity.y += gravity_scale
	if jump_pressed:
		is_jumping = true
		velocity.y = -jump_height
	# Calculating movement.
	var snap = Vector2(0,16) if !is_jumping else Vector2()
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	if is_jumping &&  velocity.y > 0:
		is_jumping = false
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
