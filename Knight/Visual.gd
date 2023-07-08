extends Node2D

@onready var DL : Sprite2D = get_node("KnightDL")
@onready var DR : Sprite2D = get_node("KnightDR")
@onready var UL : Sprite2D = get_node("KnightUL")
@onready var UR : Sprite2D = get_node("KnightUR")

const RIGHT = PI / 2
const DOWN = PI
const LEFT = 3 * PI / 2

func set_direction(dir:Vector2):
	
	# TODO: Shield
	
	DR.visible = dir.x >= 0 && dir.y >= 0
	UR.visible = dir.x >= 0 && dir.y < 0
	DL.visible = dir.x < 0 && dir.y >= 0
	UL.visible = dir.x < 0 && dir.y < 0

