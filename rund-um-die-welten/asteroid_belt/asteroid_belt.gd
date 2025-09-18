extends Node2D

@export var comet: PackedScene = preload("res://comet/comet.tscn")

#@export var min_rad = 1300
#@export var max_rad = 1520

@export var speed = 500
@export var asteroid_density = 100

@export var number_of_holes: int
@export var hole_size_in_deg: int
@export var start_rotation_in_deg = 0
var comet_radius = 40
@export var circle_radius = 400

@export var comet_margin = 10
func _ready() -> void:
	
	#var num_asteroids = 0
	#for chunk in chunks:
	#	num_asteroids += chunk[1]-chunk[0]
	#
	#num_asteroids *= max_rad-min_rad
	#
	#num_asteroids /= 700
	spawn_comets()
	
func spawn_comets():
	assert (number_of_holes * hole_size_in_deg <= 360)
	var comet_radius_in_deg = rad_to_deg(comet_radius/float(circle_radius))
	var comet_margin_in_deg = rad_to_deg(comet_margin/float(circle_radius))
	var hole_positions
	if(number_of_holes > 0):
		hole_positions = calc_hole_positions()
		
	else:
		number_of_holes = 1
		hole_positions = [0, 0]
	for i in range(number_of_holes):
		var hole_end_deg = hole_positions[2*i+1]
		var next_hole_start = hole_positions[(2*i+2)%(number_of_holes*2)]
		var last_comet_end_deg = hole_end_deg
		var end_nh_left_of_th = (hole_end_deg>=next_hole_start)
		if end_nh_left_of_th:
			next_hole_start+=360
		while(last_comet_end_deg<360):
			var left_of_next_hole = last_comet_end_deg+2*comet_radius_in_deg<next_hole_start
			if(left_of_next_hole):
				print(str(last_comet_end_deg))
				spawn_comet(last_comet_end_deg + comet_radius_in_deg)
				last_comet_end_deg +=2*comet_radius_in_deg + comet_margin_in_deg
				print(str(last_comet_end_deg))
			else:
				break
func calc_hole_positions():
	var hole_positions = []
	for i in range(number_of_holes):
		hole_positions.append(360/number_of_holes*i + start_rotation_in_deg)
		hole_positions.append(hole_positions[2*i] + hole_size_in_deg)
	return hole_positions

func spawn_comet(deg) -> void:
	print("spawn")
	var rad = deg_to_rad(deg)
	var comet_instance = comet.instantiate()
	var pos = Vector2(cos(rad), sin(rad)) * circle_radius
	comet_instance.position = pos
	comet_instance.speed = speed

	add_child(comet_instance)
