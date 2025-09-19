extends Button

var rootfolder = "res://"
var subfolder = "Levels/"
func _ready():
	# Signal verbinden
	self.pressed.connect(_on_pressed)

func _on_pressed():
	print("Selected Level is " + GlobalVariables.selected_level)
	var level_select_path = rootfolder + subfolder + GlobalVariables.selected_level + ".tscn"
	if FileAccess.file_exists(level_select_path):
		Audioplayer.play_sound((load("res://sfx/button_clicks.wav") as AudioStream))
		GlobalVariables.change_level(level_select_path)
	else :
		print("File not found under " + level_select_path)
