extends Area2D

@export var id = 0

var level 

func _ready() -> void:
	level = get_parent().level_name
	if GlobalVariables.collectibles[level][id] == 1:
		$grayscale.visible = true
		$colour.visible = false

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("collected")
		GlobalVariables.collectibles[level][id] = 1
		
		queue_free()
