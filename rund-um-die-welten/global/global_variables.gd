extends Node

var target_planet_position
enum planets {DeathStar, Mars, Earth, Sun}
var planet_names = {planets.DeathStar: "Death Star", planets.Mars: "Mars", planets.Earth: "Earth", planets.Sun: "Sun"}
var selected_level = ""
var global_RNG := RandomNumberGenerator.new()

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
	get_tree().reload_current_scene()
	
func change_level(level_select_path):
	get_tree().change_scene_to_file(level_select_path)
	restart_level()
