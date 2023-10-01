class_name PlayerJump extends State

@export var jumpForce: float = 1000.0
@export var texture : Texture2D

@export var speed : float = 100.0
@export var coyote_buffer: float = 100
var xInput: float = 0.0; 
var shouldJump: bool = false

var jumpAction: String = "ui_up"

@export var audio_stream_player: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func enter():
	super()
	sprite.set_texture(texture)
	sprite.hframes = 7
	sprite.frame = 0

	if shouldJump:
		jump()


func do():
	super()
	check_x_input()
	check_coyote_jump()
	setFrame()
	if body.is_on_floor() and body.velocity.y >= 0:
		playJumpSound()
		complete()


func physics_do():
	super()
	move()
func move():
	
	if(xInput != 0):
		body.velocity.x += xInput*speed*0.1

		body.velocity.x = clamp(body.velocity.x, -speed, speed)

		sprite.flip_h = sign(xInput) < 0
	else:
		body.velocity.x*= 0.98
func check_x_input():
	var l = Input.get_action_strength("ui_left")
	var r = Input.get_action_strength("ui_right")
	xInput = r-l

## take the velocity of the body and map it to the appropriate sprite frame
func setFrame():
	var val =   remap(body.velocity.y, -jumpForce*0.5, jumpForce, 0, sprite.hframes-1)
	val = clamp(val, 0, sprite.hframes-1)
	sprite.frame =val

func should_enter():
	return body.is_on_floor()

func jump():
	body.velocity.y = -jumpForce

func check_coyote_jump():
	if is_inputting_jump():
		if time() < coyote_buffer:
			jump()

func is_inputting_jump():
	return Input.is_action_just_pressed(jumpAction)


func exit():
	super()
	shouldJump = false

func playJumpSound():
	var t = time()/3000.0
	audio_stream_player.pitch_scale = 0.8 + randf_range(-0.05, 0.05) - t
	audio_stream_player.play()
