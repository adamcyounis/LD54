extends Node2D
@export var machine: StateMachine

@export var body: Player
@export var soul: Soul
var mat : Material
@export var hasSoul: bool = true
@export var startKneel: bool =false

# Called when the node enters the scene tree for the first time.
func _ready():
	machine.setup_tree()
	machine.set_state(body)

	if(!hasSoul && startKneel):
		body.set_state(body.kneel, true)

	mat = body.sprite.material
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	machine.do()

	if(machine.state.isComplete):
		if(machine.state == soul):
			machine.set_state(body, true)

	if(Input.is_action_just_pressed("return-to-player")and hasSoul):
		machine.set_state(soul)
		body.set_state(body.kneel, true)
		soul.set_state(soul.despawn, true)

	#on space bar, switch between body and soul
	if(Input.is_action_just_pressed("ui_accept") and hasSoul):
		if(machine.state == body):
			machine.set_state(soul, true)
			body.set_state(body.kneel, true)

		else:
			machine.set_state(body, true)


	if(soul.state == soul.despawn and hasSoul):
		mat.set_shader_parameter("replacement_color", Vector4(0.8,0.8,0.8,1))
	else: 
		mat.set_shader_parameter("replacement_color",  Vector4(19.0/256.0,19.0/256.0,29.0/256.0,1))
		
func _physics_process(_delta):
	machine.physics_do()

