extends Button

var center_position = Vector2.ZERO

func _ready() -> void:
	# set center position to rotate around
	center_position = $center_position.global_position
	print(center_position)

func _on_pressed() -> void:
	# update main to 
	$"/root/GlobalVariables".target_planet_location = center_position
