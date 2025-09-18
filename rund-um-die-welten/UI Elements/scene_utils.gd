extends Node2D


@export var pink_button_state_on_start = false
@export var orange_button_state_on_start = false
@export var green_button_state_on_start = false

func _ready() -> void:
	GlobalVariables.set_button_to("pink", pink_button_state_on_start)
	GlobalVariables.set_button_to("orange", orange_button_state_on_start)
	GlobalVariables.set_button_to("green", green_button_state_on_start)
