extends Area2D

var speed = 0
var direction = Vector2(1,0)

var target_planet_position = Vector2.ZERO
var clockwise = true

func _physics_process(delta: float) -> void:
	var radius = position.distance_to(target_planet_position)
	var angle = (position-target_planet_position).angle()
	
	var angular_speed = speed/radius
	
	if clockwise:
		angle += angular_speed*delta
	else:
		angle -= angular_speed*delta
	
	position = target_planet_position+Vector2(cos(angle), sin(angle))*radius

func _ready() -> void:
	$AnimatedSprite2D.play()

func _on_area_entered(area: Area2D) -> void:
	# if area in player group entered, kill player
	if area.is_in_group("player"):
		print("death")
