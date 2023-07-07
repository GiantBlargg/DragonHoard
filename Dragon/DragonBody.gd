extends CharacterBody2D

@export var speed: float = 500
@export var turn_speed:float = PI
@export_range(0, 180, 0.1, "radians") var forward_limit: float = PI/4
@export var tank_controls = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	var max_turn = turn_speed * delta
	
	var in_direction = Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down"))
	
	if tank_controls:
		rotate(in_direction.x * max_turn)
		
		velocity = transform.basis_xform(Vector2.DOWN)*in_direction.y*speed
		
	else:
		var direction = in_direction.limit_length()
	
		var moving = false
	
		if(direction.length_squared() > 0):
			var target_rot: float = Vector2.UP.angle_to(direction)
			var turn: float = target_rot - rotation
			turn = fposmod(turn + PI, 2*PI)-PI
			rotate(clampf(turn,-max_turn,max_turn))
			if(abs(turn)-max_turn < forward_limit):
				moving = true
		
		if moving:
			velocity = direction * speed
		else:
			velocity = Vector2(0,0)

	move_and_slide()
