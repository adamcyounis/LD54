extends Node2D
@export var machine: StateMachine

@export var body: Player
@export var soul: Soul

# Called when the node enters the scene tree for the first time.
func _ready():
	machine.setup_tree()
	machine.set_state(soul)
	
	#machine.set_state(body)
	#set_soul(false)
	#soul.collider.disabled = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	machine.do()
	#on space bar, switch between body and soul
	if(Input.is_action_just_pressed("ui_accept")):
		if(machine.state == body):
			machine.set_state(soul, true)
			set_soul(true)
		else:
			machine.set_state(body, true)
			set_soul(false)


func _physics_process(_delta):
	machine.physics_do()

func set_soul(show: bool):
	if(show):
		soul.show()
		soul.collider.disabled = false
	else:
		soul.hide()
		soul.collider.disabled = true
