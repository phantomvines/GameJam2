extends Label

func _physics_process(delta: float) -> void:
	text = "Death Count: " + str(GlobalVariables.death_counter)
