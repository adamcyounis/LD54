extends Camera2D
@export var target: Node2D
@export var followSpeed: float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = target.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = lerp(global_position, target.global_position, followSpeed*delta)

	pass
