class_name Fly extends State
var input: Vector2 = Vector2(0,0)
@export var accelSpeed: float = 300
@export var maxSpeed: float = 200
@export var decay: float =0.95

func do():
	super()
	check_input()

func physics_do():

	super()
	body.velocity += input * accelSpeed * get_physics_process_delta_time() 
	body.velocity = body.velocity.clamp(Vector2(-maxSpeed,-maxSpeed),Vector2(maxSpeed,maxSpeed))
	body.velocity *=decay
	body.move_and_slide()
	
func check_input():
	var l = Input.get_action_strength("ui_left")
	var r = Input.get_action_strength("ui_right")
	input.x = r-l

	var u = Input.get_action_strength("ui_up")
	var d = Input.get_action_strength("ui_down")
	input.y = d-u

