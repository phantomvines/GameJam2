extends Control

func _ready() -> void:
	$"Container/HSplitContainer/MarginContainer2/Respawn Button".pressed.connect(_on_respawn_button_pressed)
	$"Container/HSplitContainer/MarginContainer/Menu Button".pressed.connect(_on_menu_button_pressed)
	
	print("hi")
func _on_respawn_button_pressed():
	print("respawn")
	GlobalVariables.restart_level()
	UiManager.hide_death_screen()
	
	
func _on_menu_button_pressed():
	GlobalVariables.goto_level_select()
	UiManager.hide_death_screen()

func change_win_message(death_message: String):
	$"Container/MarginContainer/Death-message".text = death_message
	
