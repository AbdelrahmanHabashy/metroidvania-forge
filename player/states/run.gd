class_name PlayerStateRun extends PlayerState

# what happen when this state is initialized (setup for state make the state ready)
func init() -> void:
	pass
	

# what happens when you enter this state
func enter() -> void:
	# for example: play animation
	pass
	

# what happens when you exit this state
func exit() -> void:
	pass

# what happens when Input is pressed 
func handle_input (_event:InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	
	return next_state
	
# what happens each process tick (frame) in this state
func process(_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	
	return next_state


# what happens each physics_process tick (time interval) in this state
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	
	if !player.is_on_floor():
		return fall
	return next_state
