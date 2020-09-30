extends AnimatedSprite

func flip_sprite(x_velocity: float):
	if x_velocity == 0:
		return
	flip_h = x_velocity < 0
	return
