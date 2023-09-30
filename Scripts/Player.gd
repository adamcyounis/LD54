class_name Player extends State
@onready var groundControl = $StateMachine/PlayerGroundControl
@onready var airControl = $StateMachine/PlayerJump

@export var myBody: CharacterBody2D
@export var mySprite: Sprite2D

@export var gravity: Vector2
@export var wallSensors: Array [Area2D]

var xInput: float = 0.0; 
# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	body = myBody
	sprite = mySprite
	setup_tree()
	GameManager.set_player(self)

func enter():
	super()
	set_natural_state()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func do():
	super()

	if state.complete:
		set_natural_state()

	#set aircontrol if space button pressed
	if airControl.is_inputting_jump() and myBody.is_on_floor():
		airControl.shouldJump = true
		set_state(airControl, true)


func _physics_process(_delta):
	myBody.velocity += gravity
	myBody.move_and_slide()
	var counter = 0
	for sensor in wallSensors:
		if sensor.get_overlapping_bodies().size()> 1:
			counter += 1
	if (counter >= 2):
		#die
		GameManager.singleton.player_died()


func physics_do():
	super()
	
func set_natural_state():
	if(myBody.is_on_floor()):
		set_state(groundControl)
	else :
		set_state(airControl)