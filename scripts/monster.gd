extends CharacterBody2D

@export var speed:float = 400.0
@export var health:float = 200.0
@export var damage:float = 25

@onready var health_bar = %ProgressBar

func _ready():
	health_bar.max_value = health
	health_bar.value = health

func _physics_process(_delta):
	#global_position += Vector2(-speed * delta, 0)
	velocity = Vector2(-speed, 0)
	move_and_slide()
	
	var collision_count = get_slide_collision_count()
	for i in collision_count:
		var collision_info = get_slide_collision(i)
		var collider = collision_info.get_collider()
		
		if collider.has_method("take_damage"):
			collider.take_damage(damage)
			queue_free()

func take_damage(_damage):
	health -= _damage
	health_bar.value = health
	if health <= 0:
		queue_free()
	
