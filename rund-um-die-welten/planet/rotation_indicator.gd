extends Node2D

var clockwise = false
var angular_speed = 100
var radius = 100

	
func set_info() -> void:
	# set which sprites to use
	if not clockwise:
		$left_1.visible = true
		$left_2.visible = true
		$right_1.visible = false
		$right_1.visible = false
	else:
		$right_1.visible = true
		$right_2.visible = true
		$left_1.visible = false
		$left_2.visible = false
	
	$left_1.position.x = radius
	$left_2.position.x = radius * -1
	$right_1.position.x = radius
	$right_2.position.x = radius * -1

func _physics_process(delta: float) -> void:
	# rotate in direction
	if clockwise:
		rotation += deg_to_rad(angular_speed)*delta
	else:
		rotation -= deg_to_rad(angular_speed)*delta
