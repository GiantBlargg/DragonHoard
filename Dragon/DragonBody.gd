extends CharacterBody2D

@export var speed: float = 500
@export var turn_speed:float = PI
@export_range(0, 180, 0.1, "radians") var forward_limit: float = PI/4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	var max_turn = turn_speed * delta
	var turn: float = 0
	var move: Vector2 = Vector2(0,0)
	
	# Tank Controls
	turn += Input.get_axis("Turn_Left","Turn_Right") * max_turn
	move += transform.basis_xform(Vector2.DOWN) * Input.get_axis("Forward","Back") * speed

	# Arcade Controls
	var input_direction = Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down")).limit_length()
	if(input_direction.length_squared() > 0):
		var target_rot: float = Vector2.UP.angle_to(input_direction)
		turn += target_rot - rotation
		turn = fposmod(turn + PI, 2*PI)-PI
		if(abs(turn)-max_turn < forward_limit):
			move += input_direction
	
	rotate(clampf(turn,-max_turn,max_turn))
	velocity = move.limit_length() * speed
	move_and_slide()
