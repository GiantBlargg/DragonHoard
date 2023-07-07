extends Node2D

signal fire(on:bool)

@export var neck_length: float = 150

func _physics_process(delta):
	if(Input.is_action_just_pressed("Fire")):
		fire.emit(true)
	if(Input.is_action_just_released("Fire")):
		fire.emit(false)
		
	var parent_trans: Transform2D = get_parent().global_transform
		
	var target_position = parent_trans.basis_xform_inv(get_global_mouse_position() - parent_trans.origin)
	target_position = target_position.limit_length(150)
	position = target_position
	rotation = Vector2.UP.angle_to(target_position)
	
	
