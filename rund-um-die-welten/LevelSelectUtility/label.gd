extends Label

func _physics_process(_delta: float) -> void:
	text = "Death Count: " + str(GlobalVariables.death_counter)
