extends Area2D

@export var inverted = false

var clickable_area_radius = 140:
	set(value):
		clickable_area_radius = value
		$collision_shape.shape.radius = clickable_area_radius
@export var world_file_name: String:
	set(value):
		world_file_name = value
		$world_name_text.text = world_file_name
func _ready() -> void:
	if inverted:
		$inverted.visible = true
	else:
		$normal.visible = true
	$collision_shape.shape.radius = clickable_area_radius
	input_pickable = true

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		Audioplayer.play_sound((load("res://sfx/button_clicks.wav") as AudioStream))
		GlobalVariables.change_level("LevelSelectUtility/" + str(world_file_name) + ".tscn", true)
		GlobalVariables.current_world = world_file_name
