class_name Player extends CharacterBody2D

#region /// export variables
@export var move_speed:float = 100
#endregion


#region /// State Machine Variables 
var states:Array[PlayerState]
var current_state:PlayerState:
	get:return states.front() 	# returns first elemnt in states array
var previous_state:PlayerState:
	get:return states[1]
#endregion 


#region /// Standard Variables
var direction:Vector2 = Vector2.ZERO 	# Vector2.ZERO is equivelent to vector2(0, 0)
var gravity:float = 980
#endregion

func _ready() -> void:
	# Initialize states
	initialize_states()
	pass

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	pass

# runs every single frame.
# which means if the game stutters(drop frames), it might behaves inconsistently if not handled carefully
func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))
	pass

# runs on a fixed time interval (ex: 60 times per second) INDEPENDENT of frame rate
func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta
	move_and_slide()
	change_state(current_state.physics_process(_delta))
	pass


func initialize_states() -> void:
	# Gather all the states
	states = []
	for c in $States.get_children():
		if c is PlayerState:
			# order here doesn't matter because godot passes refrence to the variable NOT the value
			c.player = self
			states.append(c)
		pass
	
	# Just in case to prevent any bugs
	if states.size() == 0:
		return
		
	# Initialize all states 
	for state in states:
		state.init()
	
	# gets 
	change_state(current_state)
	current_state.enter()
	$Label.text = current_state.name

	pass 

# 
func change_state(new_state:PlayerState) -> void: 
	if new_state == null: 
		return
	elif new_state == current_state:
		return
	
	# if current_state is valid object
	if current_state: 
		current_state.exit()
	
	# puts the new state to the head of the states array
	# (without removing any states just push them back)
	states.push_front(new_state)
	# Now the new state is the current state
	# Because current state is the first state in the array
	current_state.enter()
	# Just keeps the first 3 states to prevent the array from getting masive
	states.resize(3)
	
	$Label.text = current_state.name
	pass


func update_direction() -> void:
	#var prev_direction:Vector2 = direction
	
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	
	# needs more work here
	
	pass
