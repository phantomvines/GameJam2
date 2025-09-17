extends Area2D

@export var id = 0

var level 

func _ready() -> void:
	level = get_parent().scene_file_path.split("/")[-1].split(".")[0]
	if GlobalVariables.collectibles[level][id] == 1:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("collected")
		GlobalVariables.collectibles[level][id] = 1
		
	
	queue_free()
