extends Node2D


func _physics_process(delta: float) -> void:
	var timer = get_parent().get_node("player/boost_cooldown")
	$TextureProgressBar.max_value = timer.wait_time
	
	if timer.is_stopped():
		$TextureProgressBar.value = $TextureProgressBar.max_value
	else:
		# Fill decreases as the timer counts down
		$TextureProgressBar.value = $TextureProgressBar.max_value - timer.time_left
