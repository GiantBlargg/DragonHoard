extends Node2D

@onready var DL : Sprite2D = get_node("KnightDL")
@onready var DR : Sprite2D = get_node("KnightDR")
@onready var UL : Sprite2D = get_node("KnightUL")
@onready var UR : Sprite2D = get_node("KnightUR")

@onready var anim: AnimationPlayer = get_node("AnimationPlayer")
var anim_name:String = "Movement"

const RIGHT = PI / 2
const DOWN = PI
const LEFT = 3 * PI / 2

func set_direction(dir:Vector2):
	
	# TODO: Shield
	
	DR.visible = dir.x >= 0 && dir.y >= 0
	UR.visible = dir.x >= 0 && dir.y < 0
	DL.visible = dir.x < 0 && dir.y >= 0
	UL.visible = dir.x < 0 && dir.y < 0
	
func set_anim_speed(wait:float,jump:float,start:float):
	var a = anim.get_animation(anim_name)
	var track = a.add_track(Animation.TYPE_VALUE)
	a.track_set_path(track,"AnimationPlayer:speed_scale")
	a.track_set_interpolation_type(track,Animation.INTERPOLATION_NEAREST)
	a.track_insert_key(track, 0, 1/wait)
	a.track_insert_key(track, 1, 1/jump)
	
	if start < wait:
		start /= wait
	else:
		start -= wait
		start /= jump
		start += wait
	
	anim.play(anim_name)
	anim.seek(start)

