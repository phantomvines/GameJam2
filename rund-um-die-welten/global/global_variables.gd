extends Node

var target_planet_position = Vector2(0,0)
enum planets {DeathStar, Mars}
var planet_names = {planets.DeathStar: "Death Star", planets.Mars: "Mars"}
var selected_level = ""


signal player_died(death_message: String)

func emit_player_died(death_message: String):
	player_died.emit(death_message)
