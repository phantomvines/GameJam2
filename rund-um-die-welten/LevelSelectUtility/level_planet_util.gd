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
@export var speed = 100
@export var clockwise = true

# for collectible rotating
var rotation_speed = 1000
var pos_scale = 100
var current_angles = [0, 120, 240]

func scale_locations(scale):
	$level_name_text.position.y *= scale
	for i in range(3):
		var collectible_name = "collectible"+str(i)
		get_node(collectible_name).position.x *= scale
		get_node(collectible_name).position.y *= scale
		
	
func _ready():
	var number_collectibles = sum_array(GlobalVariables.collectibles[level_id])
	for i in range (number_collectibles, 3):
		var collectible_name = "collectible"+str(i)
		get_node(collectible_name).visible = false
		
	for i in range (number_collectibles):
		var collectible_name = "collectible"+str(i)
		print(collectible_name)
		get_node(collectible_name).visible = true

func sum_array(arr: Array) -> float:
	var total = 0
	for value in arr:
		total += value
	return floor(total)

func _physics_process(delta: float) -> void:
	## rotate collectibles around planet
	#for i in range(3):
		#var collectible_name = "collectible"+str(i)
		#var collectible = get_node(collectible_name)
		#
		#var radius = scale
		#var center = $planet_body.global_position
		#var angle = (position-center).angle()
		#
		#var angular_speed = speed * 0.0002
		#angle += angular_speed*delta
		#
		#collectible.position = center+Vector2(cos(angle), sin(angle))*radius
		#print(collectible.position)
	var angular_speed = rotation_speed * delta  # Adjust multiplier as needed

	# Update each collectible's position
	for i in range(3):
		var collectible_name = "collectible"+str(i)
		var collectible = get_node(collectible_name)
		if collectible.visible:
			# Update angle
			current_angles[i] += angular_speed * delta

			# Calculate new position
			var center = $planet_body.global_position
			collectible.global_position = center + Vector2(
				cos(deg_to_rad(current_angles[i])),
				sin(deg_to_rad(current_angles[i]))
			) * pos_scale
