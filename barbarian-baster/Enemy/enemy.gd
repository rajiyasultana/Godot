extends PathFollow3D

@export var speed: float = 2.5
@export var max_health: int = 50;
var current_health: int:
	set(health_in):
		if health_in < current_health:
			animation_player.play("TakeDamage")
		current_health = health_in
		if current_health < 1:
			queue_free()

@onready var base = get_tree().get_first_node_in_group("base")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	current_health = max_health

func _process(delta: float) -> void:
	progress += delta *speed
	if(progress_ratio == 1):
		base.take_damage()
		set_process(false)
	
