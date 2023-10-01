class_name GameManager extends Node2D

@export var scenes: Array [PackedScene]
@export var sceneFader: AnimationPlayer
@export var container: Node
var player : Player
var bodyAndSoul : BodyAndSoul

static var singleton: GameManager

var scene_to_load: PackedScene
var currentScene
var playerSpawnPosition: Vector2
var died: bool = false

var chalices: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	singleton = self
	#load first scene
	var packedScene: PackedScene = scenes[0]
	load_scene(scenes[0])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(scene_to_load != null):
		go_to_level(scene_to_load)
		scene_to_load = null

static func set_player(_player: Player):
	singleton.player = _player
	singleton.playerSpawnPosition = _player.position

static func respawn_player():
	singleton.player_died()

func load_scene(_scene: PackedScene):
	currentScene = _scene
	var scene = _scene.instantiate()
	container.add_child(scene)

func go_to_level(nextScene: PackedScene):
	var d = died
	#clear child objects
	SceneOut(d)
	await sceneFader.animation_finished
	for child in container.get_children():
		child.queue_free()
	await get_tree().create_timer(0.1).timeout

	SceneIn(d)
	load_scene(nextScene)
	died = false


func prepare_level(nextScene: PackedScene):
	scene_to_load = nextScene

func player_died():
	if(!died):
		died = true
		prepare_level(currentScene)

func SceneOut(d: bool):
	if(d):
		sceneFader.play("DownStart")
	else:
		sceneFader.play("ForwardStart")
	
func SceneIn(d: bool):
	if(d):
		sceneFader.play("DownEnd")
	else:
		sceneFader.play("ForwardEnd")

func add_chalice(chalice):
	if chalice not in chalices:
		chalices.append(chalice)

func get_chalice_count():
	return chalices.size()
