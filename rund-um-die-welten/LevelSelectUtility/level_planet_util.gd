extends Control


@export var planet_type: GlobalVariables.planets:
	get:
		return $planet_body.planet_type
	set(value):
		$planet_body.planet_type = value
@export var level_id: String:
	get:
		return $planet_body.level_id
	set(value):
		$planet_body.level_id = value
		$level_name_text.text = value
@export var planet_speed = 100
@export var clockwise = true

# for collectible rotating
var rotation_speed_in_deg = 30
@export var collectibl_radius_margin = 40
var collectible_radius = 100
var collectable: PackedScene = preload("res://collectibles/collectible-icon.tscn")
var current_base_position_deg = 0
var collectable_list = []

func scale_locations(planet_radius):
	$level_name_text.position[1] = planet_radius + 20
	collectible_radius  = planet_radius + collectibl_radius_margin
	update_collectable_positions(0)
	
func _ready():
	var number_collectibles = sum_array(GlobalVariables.collectibles[level_id])
	for i in range (number_collectibles):
		var base_degree = 360 * float(i)/number_collectibles
		spawn_collectable(base_degree)

func sum_array(arr: Array) -> float:
	var total = 0
	for value in arr:
		total += value
	return floor(total)

func spawn_collectable(start_position_in_deg):
	print("Spawning collectible at position " + str(start_position_in_deg) + " plus " + str(current_base_position_deg))
	
	# Create instance
	var collectable_instance = collectable.instantiate()
	
	# Create a vector pointing to the right with length equal to collectible_radius
	var offset = Vector2(collectible_radius, 0)
	
	# Rotate it to the desired starting angle
	var start_angle_rad = deg_to_rad(current_base_position_deg + start_position_in_deg)
	offset = offset.rotated(start_angle_rad)
	
	# Set position relative to the center
	collectable_instance.position = offset
	
	# Add to scene tree and list
	add_child(collectable_instance)
	collectable_list.append(collectable_instance)


	
func _physics_process(delta: float) -> void:
	update_collectable_positions(delta)
	
func update_collectable_positions(delta: float):
	# Convert rotation speed to radians per frame
	var angular_speed_rad = deg_to_rad(rotation_speed_in_deg) * delta
	current_base_position_deg += rotation_speed_in_deg * delta

	for i in collectable_list:
		i.position = i.position.rotated(angular_speed_rad)
