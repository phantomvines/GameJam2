extends Button

var rootfolder = "res://"
var subfolder = "LevelSelectUtility/"
func _ready():
	# Signal verbinden
	self.pressed.connect(_on_pressed)

func _on_pressed():
	var level_select_path = rootfolder + subfolder +"Main_Menu" + ".tscn"
	if FileAccess.file_exists(level_select_path) or true:
		Audioplayer.play_sound((load("res://sfx/button_clicks.wav") as AudioStream))
		GlobalVariables.change_level(level_select_path, true)
	else :
		print("File not found under " + level_select_path)
