extends Node2D


func _physics_process(_delta: float) -> void:
	var timer = null
	if get_parent() and get_parent().get_parent():
		timer = get_parent().get_parent().get_node_or_null("player/boost_cooldown")

	if timer:

		$TextureProgressBar.max_value = timer.wait_time

		if timer.is_stopped():
			$TextureProgressBar.value = $TextureProgressBar.max_value
		else:
			# Fill decreases as the timer counts down
			$TextureProgressBar.value = $TextureProgressBar.max_value - timer.time_left
	else: 
		print("No timer found!")
