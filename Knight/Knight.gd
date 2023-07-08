extends CharacterBody2D

signal direction(angle:Vector2)
signal timing(wait:float,jump:float,start:float)

@export var wait_time: float = 1
@export var jump_time: float = 1
@export var jump_distance: float = 300

var timer: float = 0
var dir: Vector2 = Vector2(0,0)

@onready var anim: AnimationPlayer = get_node("Visual/AnimationPlayer")
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Dragon")

func _ready():
	timer = randf() * (wait_time+jump_time)
	timing.emit(wait_time,jump_time,timer)

func _physics_process(delta):
	timer += delta
	timer = fmod(timer, wait_time + jump_time)
	
	if timer <= wait_time:
		dir = get_direction()
		direction.emit(dir)
		velocity = Vector2(0,0)
	else:
		velocity = dir * (jump_distance / jump_time)
	
	move_and_slide()

func get_direction():
	if player == null:
		return Vector2.RIGHT
	return (player.position - position).limit_length()
