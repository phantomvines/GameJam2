extends Node2D

func _ready() -> void:
	GlobalVariables.play_music()
	# Access the button using its name
	var button = $Quit_Button
	
	# Connect the "pressed" signal to a function in this script
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	get_tree().quit()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
