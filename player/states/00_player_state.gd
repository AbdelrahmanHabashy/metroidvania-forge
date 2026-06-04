@icon("res://player/states/state.svg")
class_name PlayerState extends Node

var player : Player
var next_state: PlayerState = null

#region /// State References 
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %Jump
@onready var fall: PlayerStateFall = %Fall
@onready var crouch: PlayerStateCrouch = %Crouch
#endregion

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
	return next_state
	
# what happens each process tick (frame) in this state
func process(_delta: float) -> PlayerState:
	return next_state
	
# what happens each physics_process tick (time interval) in this state
func physics_process(_delta: float) -> PlayerState:
	return next_state
