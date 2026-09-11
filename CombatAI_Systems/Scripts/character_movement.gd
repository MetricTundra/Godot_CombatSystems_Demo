extends CharacterBody3D

var movementSpeed = 10

func _physics_process(delta: float):
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var movement = Vector3(0, 0, 0)
	movement.x = input.x
	movement.z = input.y
	velocity = movement * movementSpeed
	move_and_slide()
