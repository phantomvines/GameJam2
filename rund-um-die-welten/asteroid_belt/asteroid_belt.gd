extends Node2D

@export var comet: PackedScene = preload("res://comet/comet.tscn")

@export var min_rad = 1300
@export var max_rad = 1520

# degrees in which asteroids are present, not mentioned are spaces
@export var chunks = [[0,10], [30,100], [180,300]]

@export var speed = 500

@export var seed = 12345
@export var num_asteroids = 100

func _ready() -> void:
	rand_from_seed(seed)
	
	#var num_asteroids = 0
	#for chunk in chunks:
	#	num_asteroids += chunk[1]-chunk[0]
	#
	#num_asteroids *= max_rad-min_rad
	#
	#num_asteroids /= 700
	
	for i in range(num_asteroids):
		spawn_comet()
	

func spawn_comet():
	# Choose a random chunk
	#var chunk = chunks[randi() % chunks.size()]
	#var angle = lerpf(chunk[0], chunk[1], randf())
	
	# sum of all chunks, for weighting
	var total = 0
	for chunk in chunks:
		total += chunk[1]-chunk[0]
	
	 # Select a chunk based on weighted randomness
	var r = randf() * total
	var current_weight = 0.0
	var selected_chunk
	for chunk in chunks:
		current_weight += chunk[1] - chunk[0]
		if r <= current_weight:
			selected_chunk = chunk
			break
	
	var angle = lerpf(selected_chunk[0], selected_chunk[1], randf())
	
	# Convert angle to radians and calculate position
	var rad = deg_to_rad(angle)
	var radius = lerpf(min_rad, max_rad, randf())
	var position = Vector2(cos(rad), sin(rad)) * radius
	
		# Instantiate and add to scene
	var comet_instance = comet.instantiate()
	comet_instance.global_position = position
	comet_instance.speed = speed
	add_child(comet_instance)
