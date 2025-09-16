extends Button

func _ready():
	pressed.connect(restart_level)
func restart_level():
	#get_tree().reload_current_scene()
	GlobalVariables.emit_game_over("bla")
