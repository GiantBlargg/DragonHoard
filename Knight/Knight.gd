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
@export var damage: float = 5

var can_damage = true
var timer: float = 0
var dir: Vector2 = Vector2.RIGHT
var is_dead: bool = false
var is_flung: bool = false

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Dragon")
@onready var nav_agent: NavigationAgent2D = NavigationAgent2D.new()

func _ready():
	timer = randf() * (wait_time + jump_time)
	timing.emit(wait_time, jump_time, timer)
	add_child(nav_agent)
	nav_agent.path_desired_distance = 30
	nav_agent.target_desired_distance = 30
	nav_agent.radius = 30

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
		can_damage = true
	else:
		timer += delta
		if timer > wait_time + jump_time:
			timer = fmod(timer, wait_time + jump_time)
			get_direction()
			can_damage = true
		
		if timer <= wait_time:
			get_direction()
			velocity = Vector2(0,0)
		else:
			velocity = dir * (jump_distance / jump_time)
	
	move_and_slide()
	
	if can_damage:
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i).get_collider()
			if collision.has_method("hurt"):
				dir = -dir
				collision.hurt(damage)
				can_damage = false
				break

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
	
	nav_agent.target_position = player.position
	
	dir = (nav_agent.get_next_path_position() - position).normalized()
	if dir.is_zero_approx():
		dir = (player.position - position).normalized()
	
	direction.emit(dir)
