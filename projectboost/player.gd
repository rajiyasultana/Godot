extends RigidBody3D

func _process(delta: float) -> void:
	
	var UpForce: float = 1000.0
	var torque: Vector3 = Vector3(0.0, 0.0, 150.0 * delta)
	
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * UpForce)
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(-torque)
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(torque)
