extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	#check to see if the body belongs to GameManager.singleton.player
	if body == GameManager.singleton.player.myBody:
		GameManager.respawn_player()		
