@tool
extends Node2D

@export var parallax = Vector2(1.0,1.0)
var startPos: Vector2
var drift: Vector2
var targetPos
var targetStartPos

#@onready var body = find_children("","StaticBody2D", true)[0]
#@onready var sprite = find_children("","Sprite2D", true)[0]

@export var recalculateGeometry = false

# Called when the node enters the scene tree for the first time.
func _ready():
	targetStartPos = camPos()
	startPos = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Engine.is_editor_hint()):
		if recalculateGeometry:
			try_recalculate_geometry()
		return
	else:
		targetPos = camPos()
		drift = targetPos - targetStartPos
		var adjustedDrift = drift * parallax
		position = startPos + adjustedDrift

func camPos():
	return get_viewport().get_camera_2d().position


func try_recalculate_geometry():
	var children : Array[Node] = find_children("*","Sprite2D", true)
	var bodies : Array[Node] = find_children("*","StaticBody2D", true)
	
	if children.size() > 0 and bodies.size() > 0:
		var body = find_children("*","StaticBody2D", true)[0]
		var sprite = find_children("*","Sprite2D", true)[0]
		print("recalculating geometry")
		print(sprite)
		create_polygon2d_from_sprite2d(sprite, body)			
	recalculateGeometry = false


func create_polygon2d_from_sprite2d(_sprite: Sprite2D, _body: StaticBody2D, ):
	# Destroy Existing Collision Polygons
	for node in find_children("*", "CollisionPolygon2D"):
		node.queue_free()
	
	# Generate Bitmap from Sprite2D
	var sprite = _sprite
	var image = sprite.texture.get_image()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)
	
	# Create Collision Polygon from Opaque Pixels
	var polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, image.get_size()), 0.0)
	for poly in polys:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = poly
		_body.add_child(collision_polygon)
		collision_polygon.set_owner(get_tree().get_edited_scene_root())
		#get_tree().get_edited_scene_root()
		collision_polygon.position -= sprite.texture.get_size() / 2

