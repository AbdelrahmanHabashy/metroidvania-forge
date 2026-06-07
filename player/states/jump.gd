class_name PlayerStateJump extends PlayerState

@export var jump_velocity:float = 450.0

# what happen when this state is initialized (setup for state make the state ready)
func init() -> void:
	pass
	

# what happens when you enter this state
func enter() -> void:
	player.animation_player.play("jump")
	
	player.add_debug_indicator(Color.LIME_GREEN)
	
	player.velocity.y = -jump_velocity
	pass
	

# what happens when you exit this state
func exit() -> void:
	player.add_debug_indicator(Color.YELLOW)
	pass
	
# what happens when Input is pressed 
func handle_input (_event:InputEvent) -> PlayerState:
	if _event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state
	
# what happens each process tick (frame) in this state
func process(_delta: float) -> PlayerState:
	
	return next_state


# what happens each physics_process tick (time interval) in this state
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	
	# y-axis is inverted (it INCREASES as you go down unlike normal y-axis it DECREASES as you go down)
	if player.velocity.y >= 0:
		return fall
	
	# the player move while jumping 
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
