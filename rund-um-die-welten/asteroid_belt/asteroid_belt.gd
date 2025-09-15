extends Node2D

@export var comet: PackedScene = preload("res://comet/comet.tscn")

var min_rad = 100
var max_rad = 120

var gaps = 5
var gap_size = 30

var speed = 100

func _ready() -> void:
	# how many degrees each segment is
	var segment_length = 360 - gaps*gap_size
	
	# spawn comets in areas that are not gaps
	

func spawn_comet(pos: Vector2):
	var comet
	
	comet.instantiate()
	
	comet.global_position = pos
	comet.speed = 100
