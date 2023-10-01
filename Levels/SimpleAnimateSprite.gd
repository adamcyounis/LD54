extends Node

@export var fps : float = 10.0
@export var sprite : Sprite2D
@export var hFrames: int = 1
@export var texture: Texture
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = texture
	sprite.hframes = hFrames
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_sprite()


func update_sprite():
	var millis = Time.get_ticks_msec()
	var sec = millis/1000.0
	sprite.frame = (int(sec*fps)) % sprite.hframes;
	
