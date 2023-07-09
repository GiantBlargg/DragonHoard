extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer

func set_health(value:float,max:float):
	anim.seek((max-value)/max,true)
