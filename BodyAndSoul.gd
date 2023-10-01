class_name BodyAndSoul extends Node2D
@export var machine: StateMachine

@export var body: Player
@export var soul: Soul
var mat : Material
@export var hasSoul: bool = true
@export var startKneel: bool =false
@export var arrow: Arrow
@export var aboveHeadMarker: Node2D
var cutscene_override : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.singleton.bodyAndSoul = self

	machine.setup_tree()
	machine.set_state(body)

	if(!hasSoul && startKneel):
		body.set_state(body.kneel, true)

	mat = body.sprite.material
	body.visibility_check.screen_exited.connect(return_to_player)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	set_arrow_target()
	if(!(cutscene_override && machine.state == body)):
		machine.do()

		if(machine.state.isComplete):
			if(machine.state == soul):
				machine.set_state(body, true)
			
		handle_soul_switching_actions()

		handle_shader_colour()

		
func _physics_process(_delta):
	machine.physics_do()

func set_arrow_target():

	var soulIsOut =	soul.state == soul.fly
	arrow.visible = soulIsOut and (machine.state == body or arrow.timeSinceTargetSwitch() < 0.1)
	
	if(machine.state == body):
		arrow.target = aboveHeadMarker
		soul.sprite.modulate.a = 0.5
	else:
		arrow.target = soul.sprite
		soul.sprite.modulate.a = 1

	
func handle_soul_switching_actions():
	
	if(Input.is_action_just_pressed("return-to-player") and hasSoul and soul.state != soul.despawn):
		return_to_player()
		cutscene_override = false

	#on space bar, switch between body and soul
	if(Input.is_action_just_pressed("ui_accept") and hasSoul):
		if(machine.state == body):
			machine.set_state(soul, true)
			body.set_state(body.kneel, true)

		else:
			machine.set_state(body, true)


	if(soul.state == soul.fly && !(Input.is_action_pressed("ui_accept") or cutscene_override)):
		machine.set_state(body, true)
		

func return_to_player():
	machine.set_state(soul)
	body.set_state(body.kneel, true)
	soul.set_state(soul.despawn, true)
	soul.despawn.play_sound()

func handle_shader_colour():
	if(soul.state == soul.despawn and hasSoul):
		mat.set_shader_parameter("replacement_color", Vector4(0.8,0.8,0.8,1))
	else: 
		mat.set_shader_parameter("replacement_color",  Vector4(19.0/256.0,19.0/256.0,29.0/256.0,1))


func set_cutscene_override():
	cutscene_override = true
	
func force_soul_above_player():
	machine.set_state(soul, true)
