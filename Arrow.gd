class_name Arrow extends Sprite2D
@export var target: Node2D
@export var followSpeed: float = 1.0
@export var magnitude: float = 1.0
var targetStartPos: Vector2
var targetPos: Vector2
var oldTarget
var timeAtTargetSwitch
var fps = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var destination = target.global_position
	global_position = lerp(global_position, destination, followSpeed*delta)

	if(target != oldTarget):
		timeAtTargetSwitch = Time.get_ticks_msec()/1000.0

	oldTarget = target
	update_sprite()
	
func timeSinceTargetSwitch():
	return Time.get_ticks_msec()/1000.0 - timeAtTargetSwitch


func update_sprite():
	hframes = 7
	var millis = Time.get_ticks_msec()
	var sec = millis/1000.0
	frame = (int(sec*fps)) % hframes;
