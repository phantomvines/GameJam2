extends Area2D


# for differentiating different planets
# 0 -> death star
# 1 -> mars
@export var planet_type: GlobalVariables.planets
var center_position
var size_scale
func _ready() -> void:
	center_position = position
	input_pickable = true
	print(planet_type)
	
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
		print("Level " + GlobalVariables.planet_names[planet_type])
