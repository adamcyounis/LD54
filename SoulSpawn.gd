class_name SoulSpawn extends State
@export var decay: float =0.9
@export var spawnForce: float =60
@export var playerPos: Node2D

func enter():
	super()
	body.global_position = playerPos.global_position
	body.velocity = Vector2(0,-spawnForce)

func do():
	pass

func physics_do():
	body.move_and_slide()
	body.velocity *=decay
	if(body.velocity.length() < 10):
		complete()


func exit():
	super()