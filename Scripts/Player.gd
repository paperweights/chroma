extends KinematicBody2D

export (float) var _speed = 60
export (float) var _jump_height = 130
export (int) var _jumps = 0
export (float) var _normal_gravity = 2
export (float) var _hold_gravity = 0.5
export (float) var _coyote_time = 0.2
export (float) var terminal_velocity = 300

onready var _sprite = $AnimatedSprite
onready var _particles = $CPUParticles2D

var _input = Vector2()
var _x_velocity = Vector2()
var _y_velocity = Vector2()
var _snap = Vector2()
var _gravity_scale = 9.8
var _jump_held = false
var _jump_pressed = false
var _is_jumping = true
var _time_since_left_ground = 0
var _jump_count = _jumps

func _physics_process(delta: float):
	_get_input()
	# Horizontal movement.
	_x_velocity = _move()
	# Vertical movement.
	_y_velocity += _gravity(_get_gravity_mod())
	_jump()
	# Calculating movement.
	_update_snap()
	_y_velocity = global_transform.y.abs() * move_and_slide_with_snap(_x_velocity + _y_velocity, _snap, -global_transform.y)
	_terminal_velocity()
	_update_coyote(delta)
	_check_jumping()
	# Draw.
	_sprite.animate(get_velocity())
	_particles.emit(get_velocity())
	return

func _get_input():
	_input = Vector2()
	# Jumping.
	_jump_held = Input.is_action_pressed("player_jump")
	_jump_pressed = Input.is_action_just_pressed("player_jump")
	# Walking.
	_input.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	_input.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	return

func _move():
	return _input * _speed * global_transform.x.abs()

func _gravity(gravity_mod: float):
	return _gravity_scale * gravity_mod * global_transform.y

func _get_gravity_mod():
	if get_velocity().y < 0:
		if _jump_held:
			return _hold_gravity
		return _normal_gravity
	return 1

func _jump():
	# Wait for jump key press.
	if !_jump_pressed:
		return
	# Have to be grounded or have extra jumps.
	if !_is_grounded() && _jump_count >= _jumps:
		return
	if !_is_grounded():
		_jump_count += 1
	_is_jumping = true
	_y_velocity = -_jump_height * global_transform.y
	return

func _update_snap():
	_snap = global_transform.y * 6 if !_is_jumping else Vector2()
	return

func _terminal_velocity():
	var velocity = clamp(get_velocity().y, -terminal_velocity, terminal_velocity)
	_y_velocity = global_transform.y * velocity
	return

func _update_coyote(delta: float):
	if _is_jumping:
		_time_since_left_ground = _coyote_time
	if is_on_floor():
		_y_velocity = Vector2()
		_time_since_left_ground = 0
		_jump_count = 0
		return
	_time_since_left_ground += delta
	return

func _check_jumping():
	if _is_jumping &&  get_velocity().y > 0:
		_is_jumping = false
	return

func _is_grounded() -> bool:
	return !_is_jumping && (is_on_floor() || _time_since_left_ground < _coyote_time)

func get_velocity() -> Vector2:
	var x_vel = _x_velocity * global_transform.x
	var y_vel = _y_velocity * global_transform.y
	var velocity = Vector2()
	velocity.x = x_vel.x + x_vel.y
	velocity.y = y_vel.x + y_vel.y
	return velocity
