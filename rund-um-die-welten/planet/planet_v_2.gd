extends Area2D

@export var size_scale := 1.0  # Standardgröße (1 = 100%)

# for differentiating different planets
@export var planet_type: GlobalVariables.planets:
	set(value):
		planet_type = value
		#fit_planet_type(value)

@export var win_planet = false:
	set(value):
		win_planet = value
		if value:
			$goal.visible = true
		else:
			$goal.visible = false

@export var win_message = "You reached the goal"

@export var death_message_overwrite: String

@export var speed = 300

@export var clockwise = true:
	set (value): 
		clockwise = value
		$rotation_indicator.clockwise = clockwise
		$rotation_indicator.set_info()
		

@export var collision_enabled = true

@export var moon = true

var planet_radius = 40
func _ready():
	planet_radius 
	fit_planet_type(planet_type)
	
	# Collision anpassen (wenn z. B. CircleShape2D)
	# Reaktion auf Klick
	input_pickable = true
	
	# set rotation direction of rotation indicator
	$rotation_indicator.clockwise = clockwise
	
	fit_planet_type(planet_type)
	
	# if planet is target, display goal texture
	if win_planet:
		$goal.visible = true
	
	# set info of direction indicator, for updating
	$rotation_indicator.set_info()
	
	if moon:
		print("show moon")
		$moon.visible = true
	
		

func fit_planet_type(new_planet_type):
	print($collision)
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
	
	shape.radius = 10 * size_scale
	planet_radius = 10 * size_scale
	$rotation_indicator.set_info()
	
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		GlobalVariables.target_planet_position = global_position
		GlobalVariables.player_speed = speed
		GlobalVariables.player_clockwise = clockwise


func _on_area_entered(area: Area2D) -> void:
	if collision_enabled:
		# if area in player group entered, kill player
		if area.is_in_group("player"):
			if win_planet:
				GlobalVariables.levels[GlobalVariables.selected_level] = 1
				GlobalVariables.emit_level_done(win_message)
			else:
				if death_message_overwrite:
					GlobalVariables.emit_player_died(death_message_overwrite)
				else:
					GlobalVariables.emit_player_died("You crashed into the " + GlobalVariables.planet_names[planet_type])
				print(area.position)
		

func _physics_process(_delta: float) -> void:
	# set target symbol to visible if current planet is targeted
	if GlobalVariables.target_planet_position == global_position:
		$target.visible = true
	else:
		$target.visible = false
