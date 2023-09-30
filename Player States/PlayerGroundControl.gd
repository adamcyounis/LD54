class_name PlayerGroundControl extends State

@export var run : PlayerRun
@export var idle : PlayerIdle
var xInput: float = 0.0; 

func enter():
	super()
	if isGrounded():
		if xInput != 0:
			set_state(run, true)
		else:
			set_state(idle, true);


func do():
	super()
	print("ground control")
	var l = Input.get_action_strength("ui_left")
	var r = Input.get_action_strength("ui_right")
	xInput = r-l

	if isGrounded():
		if xInput != 0:
			set_state(run)
		else:
			set_state(idle);
	else :
		complete()

func isGrounded():
	return body.is_on_floor()
