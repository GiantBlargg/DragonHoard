extends CharacterBody2D

@export var speed: float = 500
@export var visual: Node2D 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down")).limit_length()
	
	if(direction.length_squared() > 0):
		visual.rotation = -direction.angle_to(Vector2.UP)
	
	velocity = direction * speed

	move_and_slide()
