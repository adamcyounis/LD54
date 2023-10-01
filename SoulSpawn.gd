class_name SoulSpawn extends State
@export var decay: float =0.9
@export var spawnForce: float =20
@export var playerPos: Node2D
@export var audio: AudioStreamPlayer

func enter():
	super()
	body.global_position = playerPos.global_position
	body.velocity = Vector2(0,-spawnForce)
	play_sound()
func do():
	pass

func physics_do():
	body.move_and_slide()
	body.velocity *=decay
	if(body.velocity.length() < 10):
		complete()


func exit():
	super()

	
func play_sound():
	audio.play()