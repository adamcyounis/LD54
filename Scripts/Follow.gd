class_name Follow extends Camera2D
@export var target: Node2D
@export var followSpeed: float = 1.0
@export var magnitude: float = 1.0
@export var startAtPlayerPos = false
var targetStartPos: Vector2
var targetPos: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	if(startAtPlayerPos):
		targetStartPos = target.global_position
		global_position = target.global_position

	else:
		targetStartPos = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	targetPos = target.global_position	
	var drift = targetPos - targetStartPos
	var adjustedDrift = drift * magnitude
	var destination = targetStartPos + (adjustedDrift)
	global_position = lerp(global_position, destination, followSpeed*delta)

func retarget(newTarget:NodePath):
	target = get_node(newTarget)
	print("retargeting to " + str(target))
