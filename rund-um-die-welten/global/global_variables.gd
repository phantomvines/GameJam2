extends Node

var target_planet_position = Vector2(0,0)
enum planets {DeathStar, Mars}
var planet_names = {planets.DeathStar: "Death Star", planets.Mars: "Mars"}
var selected_level = ""


signal player_died(death_message: String)
signal game_over(game_over_message: String)

func emit_player_died(death_message: String):
	player_died.emit(death_message)
	
func emit_game_over(game_over_message: String):
	game_over.emit(game_over_message)
	UiManager.show_death_screen()
