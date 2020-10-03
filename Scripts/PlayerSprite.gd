extends AnimatedSprite

var _threshold = 0.01

func _flip_sprite(x_velocity: float):
	if x_velocity == 0:
		return
	flip_h = x_velocity < 0
	return

func animate(velocity: Vector2):
	_flip_sprite(velocity.x)
	# Jumping.
	if abs(velocity.y) > _threshold:
		animation = "Jump"
	# Idle.
	elif abs(velocity.x) <= _threshold:
		animation = "Idle"
	else:
		animation = "Run"
	return
