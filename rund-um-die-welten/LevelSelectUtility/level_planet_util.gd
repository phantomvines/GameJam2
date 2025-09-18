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
		get_node(collectible_name).visible = true
func sum_array(arr: Array) -> float:
	var total = 0
	for value in arr:
		total += value
	return floor(total)
