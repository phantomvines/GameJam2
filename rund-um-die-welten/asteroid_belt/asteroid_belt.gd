extends Node2D

@export var comet: PackedScene = preload("res://comet/comet.tscn")

#@export var min_rad = 1300
#@export var max_rad = 1520

@export var speed = 500
@export var asteroid_density = 100

@export var number_of_holes: int
@export var hole_size_in_deg: int
@export var start_rotation_in_deg = 0

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
	if(number_of_holes > 0):
		var hole_positions = calc_hole_positions()
		total_comet_deg = calc_total_comet_degrees(hole_positions)

func calc_hole_positions():
	var hole_positions = []
	for i in range(number_of_holes):
		hole_positions.append(360/number_of_holes*i + start_rotation_in_deg)
		hole_positions.append(hole_positions[2*i] + hole_size_in_deg)
	return hole_positions
