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
var current_world = ""
var in_main_menu = true


#Doesnt work yet
var global_RNG := RandomNumberGenerator.new()

# Level vars
var collectibles = {"Level 1": [0,0,0], "Level 2": [0,0,0], "Level 3": [0,0,0], "Level 4": [0,0,0], "Level 5": [0,0,0], "Level 6": [0,0,0], "Level 7": [0,0,0], "Level 8": [0,0,0], "Level 9": [0,0,0], "Level 10": [0,0,0], "Level 11": [0,0,0], "Level 12": [0,0,0], "Level 13": [0,0,0], "Level 14": [0,0,0], "Level 15": [0,0,0], "Level 16": [0,0,0], "Level 17": [0,0,0], "Level 18": [0,0,0], "Level 19": [0,0,0], "Level 20": [0,0,0]}
var active_buttons = {"pink": false, "green": false, "orange": false}


var levels = {"Level 1": 0, "Level 2": 0, "Level 3": 0, "Level 4": 0, "Level 5": 0, "Level 6": 0, "Level 7": 0, "Level 8": 0, "Level 9": 0, "Level 10": 0, "Level 11": 0, "Level 12": 0, "Level 13": 0, "Level 14": 0, "Level 15": 0, "Level 16": 0, "Level 17": 0, "Level 18": 0, "Level 19": 0, "Level 20": 0};

var death_counter = 0

# Signals
# Game-State-Signals
signal player_died(death_message: String)
signal game_over(game_over_message: String)
signal level_done(win_message: String)

# Other Signals
signal button_changed_stage()

func _ready() -> void:
	pass
	
func emit_player_died(death_message: String):
	if death_message != "You left the mission area":
		Audioplayer.play_sound(preload("res://sfx/death.wav"))
	player_died.emit(death_message)
	
func emit_game_over(game_over_message: String):
	game_over.emit(game_over_message)
	
func emit_level_done(win_message: String):
	level_done.emit(win_message)
	

func goto_level_select():
	change_level("res://LevelSelectUtility/" + current_world + ".tscn", true)
	
func restart_level():
	target_planet_position = null
	if get_tree().current_scene:
		get_tree().reload_current_scene()
	
func play_music():
	if in_main_menu:
		Audioplayer.play_music("res://sfx/menu-theme.mp3")
	else:
		Audioplayer.play_music("res://sfx/Soundtrack.mp3")
	
func change_level(level_select_path, new_level_is_main_menu = false):
	get_tree().change_scene_to_file(level_select_path)
	in_main_menu = new_level_is_main_menu
	restart_level()
	reset_all_buttons()
	play_music()


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
