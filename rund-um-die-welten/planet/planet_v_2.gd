extends Area2D

@export var size_scale := 1.0  # Standardgröße (1 = 100%)
var center_position

# for differentiating different planets
# 0 -> death star
# 1 -> mars
@export var planet_type: GlobalVariables.planets

@export var win_planet = false

func _ready():
	# Sprite skalieren falls notwendig?
	#$Sprite2D.scale = Vector2(size_scale, size_scale)
	
	# Collision anpassen (wenn z. B. CircleShape2D)
	# Reaktion auf Klick
	input_pickable = true
	center_position = position
	
	# change size of collision area and animation based on which planet is chosen
	match planet_type:
		GlobalVariables.planets.DeathStar:
			size_scale = 1.0
			$death_star.play("default")
			$death_star.visible = true
		GlobalVariables.planets.Mars:
			size_scale = 1.0
			$mars.play("default")
			$mars.visible = true
	
	
	var shape = $CollisionShape2D.shape
	if shape is CircleShape2D:
		shape.radius *= size_scale
	else:
		print("not implemented")
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$"/root/GlobalVariables".target_planet_position = center_position


func _on_area_entered(area: Area2D) -> void:
	# if area in player group entered, kill player
	if area.is_in_group("player"):
		if win_planet:
			print("win")
		else:
			print("death")
