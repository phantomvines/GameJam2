extends Node

# Player vars
var target_planet_position
var player_speed
var player_clockwise
var player_skin = "default"

# Planet vars
enum planets {DeathStar, Mars, Earth, Sun, Soap, Plant, Magma, Bowling}
var planet_names = {planets.DeathStar: "Death Star", planets.Mars: "Mars", planets.Earth: "Earth", planets.Sun: "Sun", planets.Soap: "Soap", planets.Plant: "Plant", planets.Magma: "Magma", planets.Bowling: "Bowling"}
var selected_level = "Level 1"


#Doesnt work yet
var global_RNG := RandomNumberGenerator.new()

# Level vars
var collectibles = {"Level 1": [0,0,0], "Level 2": [0,0,0], "Level 3": [0,0,0], "Level 4": [0,0,0], "Level 5": [0,0,0], "Level 6": [0,0,0], "Level 7": [0,0,0], "Level 8": [0,0,0], "Level 9": [0,0,0], "Level 10": [0,0,0]}
var active_buttons = {"pink": false, "green": false, "orange": false}


var levels = {"Level 1": 0, "Level 2": 0, "Level 3": 0, "Level 4": 0, "Level 5": 0, "Level 6": 0, "Level 7": 0, "Level 8": 0, "Level 9": 0, "Level 10": 0}

# Signals
# Game-State-Signals
signal player_died(death_message: String)
signal game_over(game_over_message: String)
signal level_done(win_message: String)

# Other Signals
signal button_changed_stage()

func _ready() -> void:
	global_RNG.seed = 12345
	pass
	
func emit_player_died(death_message: String):
	if death_message != "You left the mission area":
		print("test")
		Audioplayer.play_sound(preload("res://sfx/death.wav"))
	player_died.emit(death_message)
	
func emit_game_over(game_over_message: String):
	game_over.emit(game_over_message)
	
func emit_level_done(win_message: String):
	level_done.emit(win_message)
	

func goto_level_select():
	change_level("res://LevelSelectUtility/level_select_screen.tscn")
	Audioplayer.stop_music()
	
func restart_level():
	target_planet_position = null
	global_RNG.seed = 12345
	get_tree().reload_current_scene()
	
func change_level(level_select_path):
	get_tree().change_scene_to_file(level_select_path)
	restart_level()
	Audioplayer.play_music("res://sfx/Soundtrack.mp3")
	reset_all_buttons()


# Button utils
func reset_all_buttons():
	for i in active_buttons:
		active_buttons[i] = false
	button_changed_stage.emit()

func set_button_to(button_name: String, value):
	active_buttons[button_name] = value
	button_changed_stage.emit()
	
func toggle_button(button_name: String):
	active_buttons[button_name] = !active_buttons[button_name]
	button_changed_stage.emit()
