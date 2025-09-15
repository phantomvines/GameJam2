extends Node2D

var speed = 200
# angle
var direction = 0
var target_planet_location = Vector2(100,100)
var clockwise = true

func _physics_process(delta: float) -> void:
	# get location to rotate around
	target_planet_location = $"/root/GlobalVariables".target_planet_location
	
	# calculate movement
	var radius = position.distance_to(target_planet_location)
	var angle = (position-target_planet_location).angle()
	
	var angular_speed = speed/radius
	
	if clockwise:
		angle += angular_speed*delta
	else:
		angle -= angular_speed*delta
	
	position = target_planet_location+Vector2(cos(angle), sin(angle))*radius
