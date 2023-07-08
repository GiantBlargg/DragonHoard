extends CharacterBody2D

signal direction(angle:Vector2)

@export var wait_time: float = 1
@export var jump_time: float = 1
@export var jump_distance: float = 300

var timer: float = 0
var dir: Vector2 = Vector2(0,0)

func _physics_process(delta):
	timer += delta
	timer = fmod(timer, wait_time + jump_time)
	
	if timer <= wait_time:
		dir = get_direction()
		velocity = Vector2(0,0)
	else:
		velocity = dir * (jump_distance / jump_time)
	
	move_and_slide()

func get_direction():
	return Vector2.RIGHT
