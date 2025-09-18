extends Area2D


# for differentiating different planets
@export var planet_type: GlobalVariables.planets:
	set(value):
		planet_type = value
		fit_planet_type(value)
		
@export var level_id: String
var size_scale
var planet_base_radius = 10
@export var grayscale = true

func _ready() -> void:
	input_pickable = true
	var shape = $CollisionShape2D.shape
	
	# change size of collision area and animation based on which planet is chosen
	fit_planet_type(planet_type)
	
	GlobalVariables.level_done.connect(planet_won)



func fit_planet_type(new_planet_type):
	var shape = $CollisionShape2D.shape
	# change size of collision area and animation based on which planet is chosen
	match new_planet_type:
		GlobalVariables.planets.DeathStar:
			size_scale = 1.5
			$death_star.play("default")
			$death_star.visible = true
			$goal/mars_goal.visible = true
			$rotation_indicator.radius = 30
		GlobalVariables.planets.Mars:
			size_scale = 1.5
			$mars.play("default")
			$mars.visible = true
			$goal/mars_goal.visible = true
			$rotation_indicator.radius = 30
		GlobalVariables.planets.Earth:
			size_scale = 4.2
			$earth.play("default")
			$earth.visible = true
			$goal/earth_goal.visible = true
			$rotation_indicator.radius = 55
		GlobalVariables.planets.Sun:
			size_scale = 4.8
			$sun.play("default")
			$sun.visible = true
			$goal/sun_goal.visible = true
			$rotation_indicator.radius = 65
		GlobalVariables.planets.Plant:
			size_scale = 2.0
			$plant.play("default")
			$plant.visible = true
			$goal/plant_goal.visible = true
			$rotation_indicator.radius = 30
		GlobalVariables.planets.Soap:
			size_scale = 1.9
			$soap.play("default")
			$soap.visible = true
			$goal/plant_goal.visible = true
			$rotation_indicator.radius = 30
	
	shape.radius = planet_base_radius* size_scale
	if get_parent():
		get_parent().scale_locations(planet_base_radius* size_scale * scale[0])
	
	
	
func planet_won(_win_message):
	if GlobalVariables.selected_level == level_id:
		grayscale = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Level " + GlobalVariables.planet_names[planet_type] + " with ID " + level_id)
		GlobalVariables.target_planet_position = get_parent().position
		GlobalVariables.player_speed = get_parent().planet_speed
		GlobalVariables.player_clockwise = get_parent().clockwise
		GlobalVariables.selected_level = level_id
		
func _physics_process(_delta: float) -> void:
	# set target symbol to visible if current planet is targeted
	if GlobalVariables.target_planet_position == global_position:
		$target.visible = true
	else:
		$target.visible = false
	
	if GlobalVariables.levels[level_id] == 1:
		grayscale = false
	
	if grayscale:
		match planet_type:
			GlobalVariables.planets.DeathStar:
				$death_star.modulate = Color(0.3, 0.3, 0.3)
			GlobalVariables.planets.Mars:
				$mars.modulate = Color(0.3, 0.3, 0.3)
			GlobalVariables.planets.Earth:
				$earth.modulate = Color(0.3, 0.3, 0.3)
			GlobalVariables.planets.Sun:
				$sun.modulate = Color(0.3, 0.3, 0.3)
			GlobalVariables.planets.Plant:
				$plant.modulate = Color(0.3, 0.3, 0.3)
			GlobalVariables.planets.Soap:
				$soap.modulate = Color(0.3, 0.3, 0.3)
	else:
		match planet_type:
			GlobalVariables.planets.DeathStar:
				$death_star.modulate = Color(1.0, 1.0, 1.0)
			GlobalVariables.planets.Mars:
				$mars.modulate = Color(1.0, 1.0, 1.0)
			GlobalVariables.planets.Earth:
				$earth.modulate = Color(1.0, 1.0, 1.0)
			GlobalVariables.planets.Sun:
				$sun.modulate = Color(1.0, 1.0, 1.0)
			GlobalVariables.planets.Plant:
				$plant.modulate = Color(1.0, 1.0, 1.0)
			GlobalVariables.planets.Soap:
				$soap.modulate = Color(1.0, 1.0, 1.0)
