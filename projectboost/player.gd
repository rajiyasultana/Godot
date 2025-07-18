extends RigidBody3D

@export_range(750, 3000) var UpForce: float = 1000.0
@export var torqueForce: float = 150.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * UpForce)
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torqueForce * delta))
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torqueForce * delta))
