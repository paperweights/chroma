extends KinematicBody2D

export (float) var speed = 2
export (float) var jump_height = 10
export (int) var jumps = 2
export (float) var normal_gravity = 2
export (float) var hold_gravity = 0.8

var gravity_scale = 9.8

var x_velocity = Vector2()
var y_velocity = Vector2()

var input = Vector2()
var jump_pressed = false
var jump_held = false
var jump_count = jumps
var is_grounded = false

func get_speed():
	var velocity = x_velocity.abs() + y_velocity.abs()
	return velocity.x + velocity.y

func update_input():
	input = Vector2()
	# Jumping.
	jump_held = Input.is_action_pressed("player_jump")
	jump_pressed = Input.is_action_just_pressed("player_jump")
	# Walking.
	if Input.is_action_pressed("player_up"):
		input.y -= 1
	if Input.is_action_pressed("player_down"):
		input.y += 1
	if Input.is_action_pressed("player_left"):
		input.x -= 1
	if Input.is_action_pressed("player_right"):
		input.x += 1
	return

func move(delta: float):
	var total_speed = speed * delta * input
	return total_speed * global_transform.x.abs()

func jump():
	if !jump_pressed || jump_count >= jumps:
		return
	jump_count += 1
	y_velocity = -jump_height * global_transform.y
	return

func grounded(normal: Vector2):
	return normal.round() == -global_transform.y.round()

func y_collide(collision: KinematicCollision2D):
	if collision == null:
		return
	# Reset jumps.
	y_velocity = Vector2()
	if grounded(collision.normal):
		is_grounded = true
		jump_count = 0
		return
	return

func x_collide(collision: KinematicCollision2D):
	if collision == null:
		return
	x_velocity = Vector2()
	return

func flip_sprite():
	var x_vel = x_velocity * global_transform.x
	if abs(x_vel.x + x_vel.y) < 0.1:
		return
	$AnimatedSprite.flip_h = x_vel.x + x_vel.y < 0
	return

func animate_sprite():
	var x_vel = x_velocity * global_transform.x
	# Jumping.
	if !is_grounded:
		$AnimatedSprite.animation = "Jump"
		$CPUParticles2D.emitting = false
		return
	# Idle.
	if abs(x_vel.x + x_vel.y) < 0.1:
		$AnimatedSprite.animation = "Idle"
		$CPUParticles2D.emitting = false
		return
	# Running.
	$AnimatedSprite.animation = "Run"
	$CPUParticles2D.emitting = true
	return

func get_gravity_mod():
	var y_vel = y_velocity * global_transform.y
	if y_vel.x + y_vel.y < 0:
		if jump_held:
			return hold_gravity
		return normal_gravity
	return 1

func gravity(delta: float, gravity_mod: float):
	return gravity_scale * gravity_mod * delta * global_transform.y

func _physics_process(delta):
	is_grounded = false
	update_input()
	x_velocity = move(delta)
	x_collide(move_and_collide(x_velocity))
	y_velocity += gravity(delta, get_gravity_mod())
	jump()
	y_collide(move_and_collide(y_velocity))
	# Draw.
	flip_sprite()
	animate_sprite()
	return
