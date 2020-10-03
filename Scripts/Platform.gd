extends KinematicBody2D

export (float) var speed = 1
export (Vector2) var target = Vector2.ZERO

func _physics_process(delta):
	position = position.move_toward(target, delta * speed)
	return
