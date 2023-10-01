class_name GameManager extends Node2D

@export var scenes: Array [PackedScene]
var player : Player
static var singleton: GameManager

var scene_to_load: PackedScene
var currentScene
var playerSpawnPosition: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	singleton = self
	#load first scene
	var packedScene: PackedScene = scenes[0]
	load_scene(scenes[0])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(scene_to_load != null):
		go_to_level(scene_to_load)
		scene_to_load = null

static func set_player(_player: Player):
	singleton.player = _player
	singleton.playerSpawnPosition = _player.position

static func respawn_player():
	singleton.player.position = singleton.playerSpawnPosition

func load_scene(_scene: PackedScene):
	currentScene = _scene
	var scene = _scene.instantiate()
	add_child(scene)

func go_to_level(nextScene: PackedScene):
	#clear child objects
	for child in get_children():
		child.queue_free()
	
	await get_tree().create_timer(0.1).timeout
	load_scene(nextScene)


func prepare_level(nextScene: PackedScene):
	scene_to_load = nextScene

func player_died():
	prepare_level(currentScene)
