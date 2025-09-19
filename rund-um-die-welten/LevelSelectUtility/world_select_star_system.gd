extends Area2D

var clickable_area_radius = 140:
	set(value):
		clickable_area_radius = value
		$collision_shape.shape.radius = clickable_area_radius
@export var world_file_name: String
func _ready() -> void:
		$collision_shape.shape.radius = clickable_area_radius
		input_pickable = true

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		GlobalVariables.change_level("LevelSelectUtility/" + str(world_file_name) + ".tscn")
