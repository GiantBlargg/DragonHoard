extends Node2D

var knight:PackedScene = preload("res://Knight/Knight.tscn")
@export var entrances: Array[Node2D]
var wave_num: float = 0

func _ready():
	call_deferred("spawn")

func spawn():
	for i in entrances:
		var e:Node2D = knight.instantiate()
		e.position = i.position
		get_parent().add_child(e)
