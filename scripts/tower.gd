extends StaticBody2D

@export var projectil_damage:float = 25.0
@export var shooting_speed:float = 0.5
@export var health:float = 200.0

@onready var health_bar = %HealthBar

const PROJECTIL = preload("res://assets/objects/projectil.tscn")
@onready var timer = %Timer
var counter = 0

func _ready():
	health_bar.max_value = health
	health_bar.value = health
	
	timer.wait_time = shooting_speed
	timer.timeout.connect(shot_projectil)
	timer.start()
	
func shot_projectil():
	var new_projectil = PROJECTIL.instantiate()
	new_projectil.name = str("Projectil_", counter)
	new_projectil.damage = projectil_damage
	add_child(new_projectil)
	counter += 1

func take_damage(damage):
	health -= damage
	health_bar.value = health
	if health <= 0:
		queue_free()
