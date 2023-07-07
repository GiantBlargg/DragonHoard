extends CharacterBody2D

@export var speed: float = 500
@export var stop_time: float = 0.2
@export var turn_speed:float = PI
@export_range(0, 180, 0.1, "radians") var forward_limit: float = PI/4
@export var visual: Node2D 

var rot: float = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down")).limit_length()
	
	var moving = false
	
	if(direction.length_squared() > 0):
		var target_rot: float = Vector2.UP.angle_to(direction)
		var turn: float = target_rot - rot
		turn = fposmod(turn + PI, 2*PI)-PI
		var max_turn = turn_speed * delta
		rot += clampf(turn,-max_turn,max_turn)
		if(abs(turn)-max_turn < forward_limit):
			moving = true
	
	visual.rotation = rot
	
	if moving:
		velocity = direction * speed
	else:
		velocity = Vector2(0,0)

	move_and_slide()
