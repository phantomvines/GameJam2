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
