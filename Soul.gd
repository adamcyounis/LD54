class_name Soul extends State

@export var bodyState: Node2D
@export var myBody: CharacterBody2D
@export var mySprite: Sprite2D
@export var collider: CollisionShape2D
@export var fly: Fly
@export var spawn: SoulSpawn
@export var despawn: SoulDespawn

func _ready():
	super()
	body = myBody
	sprite = mySprite
	setup_tree()

func enter():
	super()
	if(state == fly):
		set_state(fly)
		pass
	else:
		set_state(spawn, true)

func do():
	super()
	if(state.isComplete):
		if(state == spawn):
			set_state(fly, true)
		elif(state == fly):
			set_state(despawn, true)
		elif(state == despawn):
			complete()

	

func dismiss():
	set_state(despawn, true)

func _process(_delta):

	if(is_active_state() && !body.visible):	
		showMe(true)
		
	elif(!is_active_state() && state == despawn && body.visible):
		showMe(false)
		
	if(state == fly && collider.disabled):
		collideMe(true)
	elif(state != fly and !collider.disabled):
		collideMe(false)

	if !is_active_state() && state == despawn:
		body.global_position = bodyState.global_position
	#check if z key was pressed
	#toggleProcess()
	#print(collider.is_physics_processing_internal())
	



func showMe(show: bool):
	if(show):
		body.visible = true
	else:
		body.visible = false

func collideMe(collide: bool):
	if(collide):
		collider.disabled = false
	else:
		collider.disabled = true
