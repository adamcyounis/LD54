class_name SoulDespawn extends State
@export var playerPos: Node2D
@export var tolerance: float = 5
@export var audio: AudioStreamPlayer
func enter():
	super()
	body.velocity = Vector2(0,0)
	play_sound()
	
func do():
	#lerp towards playerPos
	body.global_position = lerp(body.global_position, playerPos.global_position, 0.12)

	if(distance_to_target() < tolerance):
		complete()

func distance_to_target():
	return body.global_position.distance_to(playerPos.global_position)

func exit():
	super()

func play_sound():
	audio.play()