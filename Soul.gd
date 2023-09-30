class_name Soul extends State

@export var myBody: CharacterBody2D
@export var mySprite: Sprite2D
@export var collider: CollisionShape2D
@export var fly: Fly
@export var spawn: SoulSpawn

func _ready():
	super()
	body = myBody
	sprite = mySprite
	setup_tree()
	

func enter():
	super()
	set_state(spawn, true)

func do():
	super()
	

func _process(_delta):
	if(is_active_state() && !body.visible):	
		showMe(true)
	elif(!is_active_state() && body.visible):
		showMe(false)

	if(state == fly && collider.disabled):
		collideMe(true)
	elif(state != fly and !collider.disabled):
		collideMe(false)

	#toggleProcess()
	#print(collider.is_physics_processing_internal())
	pass 



func showMe(show: bool):
	if(show):
		body.show()
	else:
		body.hide()
	
func collideMe(collide: bool):
	if(collide):
		collider.disabled = false
	else:
		collider.disabled = true
