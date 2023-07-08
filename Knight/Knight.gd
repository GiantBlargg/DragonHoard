extends CharacterBody2D

signal direction(angle:Vector2)
signal timing(wait:float,jump:float,start:float)
signal dead

@export var wait_time: float = 1
@export var jump_time: float = 1
@export var jump_distance: float = 300
@export var die_speed = 5000
@export var health: float = 100
enum KnightType {Regular, Shield, Slime}
@export var type: KnightType = KnightType.Regular

var timer: float = 0
var dir: Vector2 = Vector2.RIGHT
var is_dead: bool = false
var is_flung: bool = false

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Dragon")

func _ready():
	timer = randf() * (wait_time + jump_time)
	timing.emit(wait_time, jump_time, timer)

func _physics_process(delta):
	if is_dead:
		velocity = -dir * die_speed
		move_and_slide()
		if global_position.length_squared() > 2000000:
			queue_free()
		return
		
	if wait_time + jump_time == 0:
		get_direction()
		velocity = dir * jump_distance
	else:
		timer += delta
		if timer > wait_time + jump_time:
			timer = fmod(timer, wait_time + jump_time)
			get_direction()
		
		if timer <= wait_time:
			get_direction()
			velocity = Vector2(0,0)
		else:
			velocity = dir * (jump_distance / jump_time)
	
	move_and_slide()

func swipe():
	if type == KnightType.Slime:
		die()
		return
	if type == KnightType.Shield:
		pass
	

func fire_damage(amount:float):
	if type != KnightType.Regular:
		return
	health -= amount
	
	if health <= 0:
		die()
	
	
func die():
	is_dead = true
	dead.emit()
	collision_layer = 0
	collision_mask = 0

func get_direction():
	if player == null:
		return
	
	dir = (player.position - position).limit_length()
	
	direction.emit(dir)
