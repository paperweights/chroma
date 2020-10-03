extends CPUParticles2D

var _threshold = 0.01

func emit(velocity: Vector2):
	# Disable if jumping or falling.
	if abs(velocity.y) > _threshold:
		emitting = false
	# Disable if not moving.
	elif abs(velocity.x) <= _threshold:
		emitting = false
	# Enable otherwise.
	else:
		emitting = true 
	return
