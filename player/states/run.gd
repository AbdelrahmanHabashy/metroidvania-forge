class_name PlayerStateRun extends PlayerState


# what happen when this state is initialized (setup for state make the state ready)
func init() -> void:
	pass
	

# what happens when you enter this state
func enter() -> void:
	pass
	

# what happens when you exit this state
func exit() -> void:
	pass
	
# what happens when Input is pressed 
func handle_input (_event:InputEvent) -> PlayerState:
	return next_state
	
# what happens each process tick (frame) in this state
func process(_delta: float) -> PlayerState:
	return next_state
	
# what happens each physics_process tick (time interval) in this state
func physics_process(_delta: float) -> PlayerState:
	return next_state
