class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate:float = 10

# what happen when this state is initialized (setup for state make the state ready)
func init() -> void:
	pass
	

# what happens when you enter this state
func enter() -> void:
	player.animation_player.play("crouch")
	
	player.collision_stand.disabled  = true
	player.collision_crouch.disabled = false
	
	pass
	

# what happens when you exit this state
func exit() -> void:
	player.collision_stand.disabled  = false
	player.collision_crouch.disabled = true

	pass
	
# what happens when Input is pressed 
func handle_input (_event:InputEvent) -> PlayerState:
	# it detects collision the second it is called (we turn off shape cast to stop it from scanning needlessly)
	player.one_way_platform_shape_cast.force_shapecast_update()
	
	if _event.is_action_pressed("jump"):
		if player.one_way_platform_shape_cast.is_colliding():
			player.position.y += 4
			return fall 
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
