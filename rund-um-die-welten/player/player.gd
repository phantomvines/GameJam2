extends Area2D

var speed = 200
# angle
var direction = 0
var target_planet_position = Vector2(100,100)
var clockwise = true

func _physics_process(delta: float) -> void:
	# get location to rotate around
	target_planet_position = $"/root/GlobalVariables".target_planet_position
	
	# calculate movement
	var radius = position.distance_to(target_planet_position)
	var angle = (position-target_planet_position).angle()
	
	var angular_speed = speed/radius
	
	if clockwise:
		angle += angular_speed*delta
	else:
		angle -= angular_speed*delta
	
	position = target_planet_position+Vector2(cos(angle), sin(angle))*radius
