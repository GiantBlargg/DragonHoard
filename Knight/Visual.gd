extends Node2D

@onready var DL : Sprite2D = get_node("KnightDL")
@onready var DR : Sprite2D = get_node("KnightDR")
@onready var UL : Sprite2D = get_node("KnightUL")
@onready var UR : Sprite2D = get_node("KnightUR")

const RIGHT = PI / 2
const DOWN = PI
const LEFT = 3 * PI / 2

func set_angle(angle:float):
	angle = fposmod(angle, TAU)
	
	# TODO: Shield
	
	UR.visible = angle < RIGHT
	DR.visible = angle >= RIGHT && angle < DOWN
	DL.visible = angle >= DOWN && angle < LEFT
	UL.visible = angle >= LEFT
