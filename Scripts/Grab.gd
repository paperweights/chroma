extends Area2D

func _ready():
	$GrabCollider.disabled = true

func update_input():
	if Input.is_action_just_pressed("player_grab"):
		$GrabCollider.disabled = false
	elif Input.is_action_just_released("player_grab"):
		$GrabCollider.disabled = true
	return

func _physics_process(delta: float):
	update_input()
	return


func _on_grab(body):
	print(body)
	return


func _on_release(body):
	print(body)
	return
