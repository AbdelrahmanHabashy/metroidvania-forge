class_name PlayerStateJump extends PlayerState

var jump_time:float = 0
var max_jump_time:float = 0.5
var jump_force:float = 100

# what happen when this state is initialized (setup for state make the state ready)
func init() -> void:
	pass
	

# what happens when you enter this state
func enter() -> void:
	# for example: play animation
	jump_time = 0 
	player.velocity.y -= jump_force
	pass
	

# what happens when you exit this state
func exit() -> void:
	pass
	
# what happens when Input is pressed 
func handle_input (_event:InputEvent) -> PlayerState:
	if _event.is_action_released("jump"):
		return fall
	return next_state

# what happens each process tick (frame) in this state
func process(_delta: float) -> PlayerState:
	#if jump_height == 0:
		#return fall
	return next_state


# what happens each physics_process tick (time interval) in this state
func physics_process(_delta: float) -> PlayerState:
	jump_time += _delta
	print(jump_time)
	if Input.is_action_pressed("jump") and jump_time < max_jump_time:
		player.velocity.y -= 20
	return next_state
