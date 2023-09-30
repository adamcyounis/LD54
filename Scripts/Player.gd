class_name Player extends CharacterBody2D
@onready var machine = $StateMachine
@onready var groundControl = $StateMachine/PlayerGroundControl
@onready var airControl = $StateMachine/PlayerJump
@export var sprite: Sprite2D

@export var gravity: Vector2

@export var wallSensors: Array [Area2D]


var xInput: float = 0.0; 
# Called when the node enters the scene tree for the first time.
func _ready():
	machine.body = self
	machine.sprite = sprite
	machine.setup_tree()
	machine.set_state(groundControl)
	GameManager.set_player(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if machine.state.complete:
		if(is_on_floor()):
			machine.set_state(groundControl)
		else :
			machine.set_state(airControl)

	#set aircontrol if space button pressed
	if airControl.is_inputting_jump() and is_on_floor():
		airControl.shouldJump = true
		machine.set_state(airControl, true)

	machine.do()


func _physics_process(_delta):
	machine.physics_do()
	velocity += gravity
	move_and_slide()
	var counter = 0
	for sensor in wallSensors:
		if sensor.get_overlapping_bodies().size()> 1:
			counter += 1

	if (counter >= 2):
		#die
		GameManager.singleton.player_died()
