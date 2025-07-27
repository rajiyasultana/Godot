extends Node3D

@export var projectile: PackedScene
@onready var turret_top: MeshInstance3D = $TurretBase/TurretTop

func _on_timer_timeout() -> void:
	var shot = projectile.instantiate()
	add_child(shot)
	shot.global_position = turret_top.global_position
