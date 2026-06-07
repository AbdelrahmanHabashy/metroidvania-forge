class_name Player extends CharacterBody2D

const DENUG_JUMP_INDICATOR = preload("uid://cqppctwvp1td6")


#region /// @onready Variables
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_shape_cast: ShapeCast2D = $OneWayPlatformShapeCast
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion

#region /// export variables
@export var move_speed:float = 150
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
var gravity_multiplier:float = 1.0
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
	velocity.y += gravity * _delta * gravity_multiplier
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
	var prev_direction:Vector2 = direction
	
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	
	if prev_direction.x != direction.x:
		if direction.x < 0: 	# checks if the player facing left
			sprite.flip_h = true
		elif direction.x > 0: 	# checks if the player facing right
			sprite.flip_h = false
	
	pass


func add_debug_indicator(color:Color = Color.RED) -> void:
	var d:Node2D = DENUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer(3.0).timeout
	d.queue_free()
	
	pass
