extends Node2D

@export var max_activation_dist = 100:
	set(value):
		max_activation_dist = value
		$activation_area/shape.shape.radius = $planet_v2.planet_radius + max_activation_dist
var block_trigger = false
@export var button_color: String:
	set(value):
		button_color = value
		for i in ["Orange", "Green", "Pink"]:
			get_node("Color/"+str(i)).visible = false
			
		get_node("Color/"+str(value).capitalize()).visible = true

@export var size_scale := 1.0:
	set(value):
		size_scale = value
		$planet_v2.size_scale = value

@export var planet_type: GlobalVariables.planets:
	set(value):
		planet_type = value
		$planet_v2.planet_type = value

@export var win_planet := false:
	set(value):
		win_planet = value
		$planet_v2.win_planet = value

@export var win_message := "You reached the goal":
	set(value):
		win_message = value
		$planet_v2.win_message = value

@export var death_message_overwrite: String:
	set(value):
		death_message_overwrite = value
		$planet_v2.death_message_overwrite = value

@export var speed := 300:
	set(value):
		speed = value
		$planet_v2.speed = value

@export var clockwise := true:
	set(value):
		clockwise = value
		$planet_v2.clockwise = value

@export var collision_enabled := true:
	set(value):
		collision_enabled = value
		$planet_v2.collision_enabled = value


func _ready() -> void:
	
	$planet_v2.size_scale = size_scale

	# for differentiating different planets
	$planet_v2.planet_type = planet_type

	$planet_v2.win_planet = win_planet

	$planet_v2.win_message = win_message

	$planet_v2.death_message_overwrite = death_message_overwrite

	$planet_v2.speed = speed

	$planet_v2.clockwise = clockwise

	$planet_v2.collision_enabled = collision_enabled
	
	$activation_area/shape.shape.radius = $planet_v2.planet_radius + max_activation_dist
	
	var scale_factor = ($planet_v2.planet_radius+ max_activation_dist)/float(12)
	$Color.scale = Vector2(scale_factor, scale_factor)
	
	
func _physics_process(_delta: float) -> void:
	#Check if player is orbiting this planet on low orbit
	if is_player_in_area():
		if GlobalVariables.target_planet_position == position && !block_trigger: 
			GlobalVariables.toggle_button(button_color)
			block_trigger = true
	else:
		block_trigger = false
				
func is_player_in_area() -> bool:
	for body in $activation_area.get_overlapping_areas():
		if body.is_in_group("player"):
			return true
	return false
