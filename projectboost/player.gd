extends RigidBody3D

@export_range(750, 3000) var UpForce: float = 1000.0
@export var torqueForce: float = 150.0

var is_transitioning = false

@onready var exploision_sound: AudioStreamPlayer = $"Exploision sound"
@onready var success_sound: AudioStreamPlayer = $"Success Sound"
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $LeftBoosterParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles

func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * UpForce)
		booster_particles.emitting = true
		if rocket_audio.playing == false:
			rocket_audio.play()
	else:
		rocket_audio.stop()
		booster_particles.emitting = false
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torqueForce * delta))
		left_booster_particles.emitting = true
	else:
		left_booster_particles.emitting = false
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torqueForce * delta))
		right_booster_particles.emitting = true
	else:
		right_booster_particles.emitting = false

func _on_body_entered(body: Node) -> void:
	if is_transitioning == false:
		if "Goal" in body.get_groups():
			completeLevel(body.file_path)

		if "Hazard" in body.get_groups():
			crushSequence() 

func crushSequence() -> void:
	print("BOOM!")
	exploision_sound.play()
	explosion_particles.emitting = true
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(2.5)
	tween.tween_callback(get_tree().reload_current_scene)
	
func completeLevel(nextLevelFile: String) -> void:
	print("Complete!")
	success_particles.emitting = true
	success_sound.play()
	set_process(false)
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(2)
	tween.tween_callback(get_tree().change_scene_to_file.bind(nextLevelFile))
	
