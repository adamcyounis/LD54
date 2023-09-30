extends Camera2D

@export var points: Array[Node2D]
@export var interval: float = 3
@export var index: int = 0
var timeAtStart: float = 0
var targetPos = Vector2(0,0)
@export var speed = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	Next()
	global_position = targetPos
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(stateTime() > interval):
		Next()
	
	#print(stateTime())
	global_position = lerp(global_position, targetPos, _delta*speed)


func Next():
	timeAtStart = time()
	index += 1
	index = index % points.size()
	targetPos = points[index].global_position


func time():
	return Time.get_ticks_msec()/1000.0

func stateTime():
	return time() - timeAtStart
