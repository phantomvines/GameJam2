extends Button

var center_position = Vector2.ZERO

func _ready() -> void:
	# set center position to rotate around
	center_position = $center_position.position

func _on_pressed() -> void:
	# update main to 
	$"/root/GlobalVariables".target_planet_position = center_position
