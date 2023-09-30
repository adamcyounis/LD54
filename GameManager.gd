class_name GameManager extends Node2D

@export var scenes: Array [PackedScene]
var player : Player
static var singleton: GameManager
# Called when the node enters the scene tree for the first time.
func _ready():
	singleton = self
	#load first scene
	var packedScene: PackedScene = scenes[0]
	var scene = packedScene.instantiate()
	add_child(scene)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

static func set_player(_player: Player):
	singleton.player = _player
