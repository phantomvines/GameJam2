extends Node2D

@export var level_name = ""
var collectibles = [0,0,0]

func _ready() -> void:
	GlobalVariables.level_done.connect(save_collectibles)

	

func save_collectibles(_win_message):
	GlobalVariables.collectibles[level_name] += collectibles
