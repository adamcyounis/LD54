extends Area2D

@export var sprite: Sprite2D
var fps: float = 8.0
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_sprite()
	pass

func on_body_entered(body):
	#check to see if the body belongs to GameManager.singleton.player
	if body == GameManager.singleton.player.myBody:
		GameManager.singleton.add_chalice(self)
		queue_free()		


func update_sprite():
	var millis = Time.get_ticks_msec()
	var sec = millis/1000.0
	sprite.frame = (int(sec*fps)) % sprite.hframes;
	
