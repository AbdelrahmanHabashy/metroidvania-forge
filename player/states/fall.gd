class_name PlayerStateFall extends PlayerState

@export var fall_gravity_multiplier:float = 1.165

# it makes the player can jump even he fell for a very small amount of time (for people slow in the haed)
@export var coyote_time:float = 0.125
var coyote_timer:float = 0

# the player can jump just before touching the floor 
@export var jump_buffer_time:float = 0.2
var buffer_timer:float = 0

# what happen when this state is initialized (setup for state make the state ready)
func init() -> void:
	pass
	

# what happens when you enter this state
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	
	# to make the player fall faster than he goes up
	player.gravity_multiplier = fall_gravity_multiplier
	
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass
	

# what happens when you exit this state
func exit() -> void:
	# resets the multiplier 
	player.gravity_multiplier = 1.0
	
	# reseting buffer time to prevent jumping when falling twice too fast 
	buffer_timer = 0
	pass
	
# what happens when Input is pressed 
func handle_input (_event:InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if coyote_timer > 0:
			return jump
		else:
			buffer_timer = jump_buffer_time
	
	return next_state
	
# what happens each process tick (frame) in this state
func process(_delta: float) -> PlayerState:
	coyote_timer -= _delta
	buffer_timer -= _delta
	set_jump_frame()
	
	return next_state


# what happens each physics_process tick (time interval) in this state
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		#player.add_debug_indicator(Color.RED)
		#if buffer_timer > 0 && Input.is_action_pressed("jump"):
		if buffer_timer > 0:
			return jump
		return idle
	
	# the player moves while falling
	player.velocity.x = player.direction.x * player.move_speed
	return next_state


func set_jump_frame() -> void:
	# As the velocity changes (e.g., from -400 up to 0), 
	# the remap function calculates exactly where that value sits 
	# within the input range and translates it into 
	# the proportional time value within the output range (0 to 0.5).
	var frame:float = remap(player.velocity.y, 0.0, player.max_fall_velocity, 0.5, 1.0)
	player.animation_player.seek(frame, true)
	pass
