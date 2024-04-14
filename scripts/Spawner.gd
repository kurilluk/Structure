extends Marker2D

@export var interval_min:float = 2
@export var interval_max:float = 3
@export var monsters: Array[PackedScene] = []
@onready var enemies = %Enemies
@onready var animation_player = %AnimationPlayer

const MONSTER = preload("res://assets/objects/monster.tscn")

func _ready():
	spawn_monster()
	animation_player.play("moving")

func spawn_monster():
	var new_monster = monsters.pick_random().instantiate()
	new_monster.position = global_position
	enemies.add_child(new_monster)
	get_tree().create_timer(randf_range(interval_min,interval_max)).timeout.connect(spawn_monster)
