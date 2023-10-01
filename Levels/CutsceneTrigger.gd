class_name CutsceneTrigger extends Area2D
var triggered = false

@export var dummySoul: Sprite2D
@export var camera: Follow
@export var animator: AnimationPlayer
var sceneIndex : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	animator.animation_finished.connect(respond_to_finish)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("return-to-player") and sceneIndex == 1:
		animator.play("Cutscene2")

	if Input.is_action_just_pressed("ui_accept") and sceneIndex == 2:
		animator.play("Cutscene3")
	

func _on_body_entered(body):
	#check to see if the body belongs to GameManager.singleton.player
	if body == GameManager.singleton.player.myBody && !triggered:
		start_cutsene()

func start_cutsene():
	triggered = true;
	var bs = GameManager.singleton.bodyAndSoul
	bs.hasSoul = true
	#bs.machine.set_state(bs.soul, true)
	bs.body.set_state(bs.body.kneel, true)
	animator.play("Cutscene")
	GameManager.singleton.bodyAndSoul.set_cutscene_override()

func finish_cutscene():
	#turn off dummy sprite
	dummySoul.visible = false
	camera.target = GameManager.singleton.bodyAndSoul.soul.sprite
	GameManager.singleton.bodyAndSoul.force_soul_above_player()
	GameManager.singleton.bodyAndSoul.soul.body.global_position = dummySoul.global_position
	GameManager.singleton.bodyAndSoul.soul.spawn.stopMoving()
	
func respond_to_finish(name: String):
	sceneIndex+=1
