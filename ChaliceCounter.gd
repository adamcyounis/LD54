extends CanvasLayer

@export var label: Label
@export var texture: TextureRect

var prevSize = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	label.modulate.a = 0
	texture.modulate.a = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

	if(size() != prevSize):
		label.modulate.a = 4
		texture.modulate.a = 4

	label.modulate.a -= 0.02
	texture.modulate.a -= 0.02

	prevSize = GameManager.singleton.chalices.size()

	label.text = str(GameManager.singleton.chalices.size())

func size():
	return GameManager.singleton.chalices.size()
