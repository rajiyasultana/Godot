extends RigidBody3D

func _process(delta: float) -> void:
	
	var UpForce: float = 1000.0
	var torque: Vector3 = Vector3(0.0, 0.0, 100.0 * delta)
	
	if Input.is_action_pressed("ui_accept"):
		apply_central_force(Vector3.UP * delta * UpForce)
		
	if Input.is_action_pressed("ui_right"):
		apply_torque(-torque)
		
	if Input.is_action_pressed("ui_left"):
		apply_torque(torque)
