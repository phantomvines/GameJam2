extends Area2D

var speed = 100
var direction = Vector2(1,0)

var target_planet_position
var clockwise = true

var vis = false

func _physics_process(delta: float) -> void:
	var radius = 150
	var angle = (position-target_planet_position).angle()
	
	var angular_speed = speed * delta
	
	if clockwise:
		angle += angular_speed*delta
	else:
		angle -= angular_speed*delta
	
	position = target_planet_position+Vector2(cos(angle), sin(angle))*radius

func _ready() -> void:
	target_planet_position = get_parent().global_position
	$AnimatedSprite2D.play()

func _on_area_entered(area: Area2D) -> void:
	# if area in player group entered, kill player
	if area.is_in_group("player") and vis:
		#Comet = Meteroid with dust trail
		GlobalVariables.emit_player_died("You missed your target and crashed into a moon")
