extends Node2D

signal fire(on:bool)

@export var neck_length: float = 150
@export var fire_damage: float = 100

@onready var fire_area: Area2D = get_node("FireArea")

var firing:bool = false

func _physics_process(delta):
	if(Input.is_action_just_pressed("Fire")):
		firing = true
		fire.emit(true)
	if(Input.is_action_just_released("Fire")):
		firing = false
		fire.emit(false)
		
	var parent_trans: Transform2D = get_parent().global_transform
		
	var target_position = parent_trans.basis_xform_inv(get_global_mouse_position() - parent_trans.origin)
	target_position = target_position.limit_length(150)
	position = target_position
	rotation = Vector2.UP.angle_to(target_position)
	
	if firing:
		var targets = fire_area.get_overlapping_bodies()
		for t in targets:
			if t.has_method("fire_damage"):
				t.fire_damage(fire_damage*delta)
			
