extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var targetPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#on mouse click, set targetPos to mouse position
	pass # Replace with function body.

func _process(delta):
	global_position = lerp(global_position, targetPos, 0.1)
	print(targetPos)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		targetPos = get_global_mouse_position()

