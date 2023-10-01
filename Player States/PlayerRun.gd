class_name PlayerRun extends State
@export var texture: Texture2D 

@export var speed : float = 100.0
@onready var audio_stream_player = $AudioStreamPlayer


var xInput: float = 0.0; 
@export var fps: float = 13.0


var currentFrame: int = 0
var prevFrame: int = 0

func enter():
	super()
	check_x_input()
	sprite.texture = texture
	sprite.hframes = 8

func do():
	super()
	check_x_input()
	update_frame()
	currentFrame = sprite.frame
	if(prevFrame != currentFrame ):
		if(currentFrame == 0 or currentFrame == 4):
			playStepSound()

	prevFrame = currentFrame


func physics_do():
	super()
	move()

func move():
	body.velocity.x = xInput*speed
	
	if(xInput != 0):
		sprite.flip_h = sign(xInput) < 0
	else:
		complete()

func check_x_input():
	var l = Input.get_action_strength("ui_left")
	var r = Input.get_action_strength("ui_right")
	xInput = r-l

func isGrounded():
	return body.is_on_floor()

func update_frame():
	var millis = Time.get_ticks_msec()
	var sec = millis/1000.0
	sprite.set_texture(texture)
	sprite.frame = (int(sec*fps)) % sprite.hframes;

func playStepSound():
	#audio_stream_player.play()
	pass
