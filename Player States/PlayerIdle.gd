class_name PlayerIdle extends State
@export var hFrames = 1;
@export var fps = 10;
@export var texture: Texture2D

func enter():
	super()
	sprite.set_texture(texture)
	sprite.frame = 0
	sprite.hframes = hFrames
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func do():
	super()
	var millis = Time.get_ticks_msec()
	var sec = millis/1000.0
	sprite.set_texture(texture)
	sprite.frame = (int(sec*fps)) % sprite.hframes;
	pass

func physics_do():
	super()
	body.velocity.x = 0
