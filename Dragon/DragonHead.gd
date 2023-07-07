extends Node2D

signal fire(on:bool)

func _physics_process(delta):
	if(Input.is_action_just_pressed("Fire")):
		fire.emit(true)
	if(Input.is_action_just_released("Fire")):
		fire.emit(false)
	
