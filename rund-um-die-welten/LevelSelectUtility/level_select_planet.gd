extends Area2D


# for differentiating different planets
@export var planet_type: GlobalVariables.planets
@export var level_id: String
var size_scale
func _ready() -> void:
	input_pickable = true
	var shape = $CollisionShape2D.shape
	
	# change size of collision area and animation based on which planet is chosen
	match planet_type:
		GlobalVariables.planets.DeathStar:
			size_scale = 1.5
			$death_star.play("default")
			$death_star.visible = true
		GlobalVariables.planets.Mars:
			size_scale = 1.5
			$mars.play("default")
			$mars.visible = true
		GlobalVariables.planets.Earth:
			size_scale = 4.2
			$earth.play("default")
			$earth.visible = true
		GlobalVariables.planets.Sun:
			size_scale = 4.8
			$sun.play("default")
			$sun.visible = true
	
	shape.radius *= size_scale
	get_parent().scale_locations(size_scale)
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Level " + GlobalVariables.planet_names[planet_type] + " with ID " + level_id)
		GlobalVariables.target_planet_position = get_parent().position
		GlobalVariables.player_speed = get_parent().speed
		GlobalVariables.player_clockwise = get_parent().clockwise
		GlobalVariables.selected_level = level_id
		
func _physics_process(delta: float) -> void:
	# set target symbol to visible if current planet is targeted
	if GlobalVariables.target_planet_position == global_position:
		$target.visible = true
	else:
		$target.visible = false
