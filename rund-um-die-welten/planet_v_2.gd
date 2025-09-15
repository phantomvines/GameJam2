extends Area2D

@export var size_scale := 1.0  # Standardgröße (1 = 100%)
var center_position

func _ready():
	# Sprite skalieren falls notwendig?
	#$Sprite2D.scale = Vector2(size_scale, size_scale)

	# Collision anpassen (wenn z. B. CircleShape2D)
	var shape = $CollisionShape2D.shape
	if shape is CircleShape2D:
		shape.radius *= size_scale
	else:
		print("not implemented")

	# Reaktion auf Klick
	input_pickable = true
	center_position = position
	$AnimatedSprite2D.play("default")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$"/root/GlobalVariables".target_planet_position = center_position
