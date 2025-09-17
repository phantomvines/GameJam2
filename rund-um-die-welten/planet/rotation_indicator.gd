extends Node2D

var clockwise = false
var speed = 1
var radius = 100

func set_info() -> void:
	# set which sprites to use
	if not clockwise:
		$left_1.visible = true
		$left_2.visible = true
	else:
		$right_1.visible = true
		$right_2.visible = true
	
	# set radius for all sprites
	$left_1.position.x += radius
	$left_2.position.x -= radius
	$right_1.position.x += radius
	$right_2.position.x -= radius

func _physics_process(delta: float) -> void:
	# rotate in direction
	if clockwise:
		rotation += deg_to_rad(speed)
	else:
		rotation -= deg_to_rad(speed)
