class_name State extends Node

var children: Array#[State] = []
var parentState: State
var state: State
var isComplete: bool = false

var sprite : Sprite2D
var body : CharacterBody2D
var startTime : int = 0

signal do_signal
signal physics_do_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			
			children.append(child)
			child.setup_parent(self)
			
func set_state(newState : State, overRide:bool = false):
	if newState != null and (state != newState || overRide):
		if state != null:
			state.exit()

		state = newState
		state.parentState = self
		state.enter()

func enter():
	isComplete = false;
	startTime = Time.get_ticks_msec();

func do():
	if state != null and !state.isComplete:
		state.do()

func physics_do():
	if state != null and !state.isComplete:
		state.physics_do()

func complete():
	isComplete = true

func exit():
	pass

func should_enter():
	return true

func setup_parent(newState: State):
	parentState = newState

func setup_core():
	if(parentState.sprite != null):
		sprite = parentState.sprite
	
	if(parentState.body != null):
		body = parentState.body

func setup_tree():
	for child in children:
		child.setup_core()
		child.setup_tree()

func time():
	return Time.get_ticks_msec() - startTime

func is_active_state():
	return parentState.state == self