class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate:float = 10

# what happen when this state is initialized (setup for state make the state ready)
func init() -> void:
	pass
	

# what happens when you enter this state
func enter() -> void:
	# for example: play animation
	player.collision_stand.disabled  = true
	player.collision_crouch.disabled = false
	player.sprite.scale.y = 0.625
	player.sprite.position.y = -15.0

	
	pass
	

# what happens when you exit this state
func exit() -> void:
	player.collision_stand.disabled  = false
	player.collision_crouch.disabled = true
	player.sprite.scale.y = 1.0
	player.sprite.position.y = -24

	pass
	
# what happens when Input is pressed 
func handle_input (_event:InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state
	
# what happens each process tick (frame) in this state
func process(_delta: float) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state


# what happens each physics_process tick (time interval) in this state
func physics_process(_delta: float) -> PlayerState:
	# to make stopping takes some time. when the player crouches he will decelrates quickly until he stops
	player.velocity.x -= player.velocity.x * deceleration_rate * _delta
	
	if !player.is_on_floor():
		return fall
	
	return next_state
