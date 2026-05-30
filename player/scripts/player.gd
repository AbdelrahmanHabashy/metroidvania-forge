class_name Player extends CharacterBody2D



# runs every single frame.
# which means if the game stutters, it might behaves inconsistently if not handled carefully
func _process(_delta: float) -> void:
	
	pass

# runs on a fixed time interval (ex: 60 times per second) INDEPENDENT of frame rate
func _physics_process(_delta: float) -> void:
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -100
	elif Input.is_action_pressed("right"):
		velocity.x = +100
	
	velocity.y = velocity.y + 980*_delta
	move_and_slide()
	pass
