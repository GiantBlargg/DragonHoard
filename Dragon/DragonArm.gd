extends Area2D

signal swipe

func _physics_process(delta):
	if Input.is_action_just_pressed("Swipe"):
		swipe.emit()
		var targets = get_overlapping_bodies()
		for t in targets:
			if t.has_method("swipe"):
				t.swipe()
