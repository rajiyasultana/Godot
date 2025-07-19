extends RigidBody3D

@export_range(750, 3000) var UpForce: float = 1000.0
@export var torqueForce: float = 150.0
var is_transitioning = false


func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * UpForce)
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torqueForce * delta))
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torqueForce * delta))

func _on_body_entered(body: Node) -> void:
	if is_transitioning == false:
		if "Goal" in body.get_groups():
			completeLevel(body.file_path)

		if "Hazard" in body.get_groups():
			crushSequence() 

func crushSequence() -> void:
	print("BOOM!")
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().reload_current_scene)
	
func completeLevel(nextLevelFile: String) -> void:
	print("Complete!")
	var tween = create_tween()
	tween.tween_interval(1.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(nextLevelFile))
	
