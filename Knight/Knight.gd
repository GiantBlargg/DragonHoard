extends CharacterBody2D

signal angle(angle:float)

@export var wait_time: float
@export var jump_time: float
@export var jump_distance: float

@onready var jump_timer = Timer.new()


