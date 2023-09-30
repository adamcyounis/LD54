@tool
extends Node2D

@export var parallax = Vector2(1.0,1.0)
var startPos: Vector2
var drift: Vector2
var targetPos
var targetStartPos


@export var recalculateGeometry = false

# Called when the node enters the scene tree for the first time.
func _ready():
	targetStartPos = camPos()
	startPos = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Engine.is_editor_hint()):
		if recalculateGeometry:
			print("recalculating geometry")

			recalculateGeometry = false
		return
	else:
		targetPos = camPos()
		drift = targetPos - targetStartPos
		var adjustedDrift = drift * parallax
		position = startPos + adjustedDrift

func camPos():
	return get_viewport().get_camera_2d().position


