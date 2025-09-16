extends Node

var target_planet_position
enum planets {DeathStar, Mars, Earth, Sun}
var planet_names = {planets.DeathStar: "Death Star", planets.Mars: "Mars", planets.Earth: "Earth", planets.Sun: "Sun"}
var selected_level = ""
var global_RNG := RandomNumberGenerator.new()

var collectibles = {"Level 1": [0,0,0], "Level 2": [0,0,0], "Level 3": [0,0,0], "Level 4": [0,0,0], "Level 5": [0,0,0], "Level 6": [0,0,0], "Level 7": [0,0,0], "Level 8": [0,0,0], "Level 9": [0,0,0], "Level 10": [0,0,0]}

signal player_died(death_message: String)
signal game_over(game_over_message: String)
signal level_done(win_message: String)

func _ready() -> void:
	global_RNG.seed = 12345
	pass
	
func emit_player_died(death_message: String):
	player_died.emit(death_message)
	
func emit_game_over(game_over_message: String):
	game_over.emit(game_over_message)
	
func emit_level_done(win_message: String):
	level_done.emit(win_message)
	

func goto_level_select():
	change_level("res://LevelSelectUtility/level_select_screen.tscn")
	
func restart_level():
	target_planet_position = null
	global_RNG.seed = 12345
	get_tree().paused = true
	get_tree().reload_current_scene()
	get_tree().paused = false
	
func change_level(level_select_path):
	get_tree().change_scene_to_file(level_select_path)
	restart_level()
