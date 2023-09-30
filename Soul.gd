class_name Soul extends State

@export var myBody: CharacterBody2D
@export var mySprite: Sprite2D
@export var collider: CollisionShape2D
@export var fly: Fly

func _ready():
	super()
	body = myBody
	sprite = mySprite
	setup_tree()
	
func do():
	super()
	

func _process(_delta):
	#toggleProcess()
	#print(collider.is_physics_processing_internal())
	pass 

func toggleProcess():
	if(body != null):
		
		if body.process_mode == PROCESS_MODE_INHERIT  and parentState.state != self:
			#body.set_process(false)
			collider.set_physics_process(false)
		elif body.process_mode == PROCESS_MODE_DISABLED and parentState.state == self:
			#body.set_process(true)
			collider.set_physics_process(true)

func enter():
	super()
	set_state(fly)
