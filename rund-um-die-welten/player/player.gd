extends Area2D

@export var speed = 130
# angle
var direction = 0
@export var target_planet_position = Vector2(100,100)
var clockwise = true
@export var dies_on_screen_leave = false
@export var respawn_point: Vector2
@export var auto_respawn = false

func _ready() -> void:
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)
	$VisibleOnScreenNotifier2D.screen_entered.connect(_on_screen_entered)
	GlobalVariables.player_died.connect(player_dies)
	
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
	
	#print(angle)
	$Sprite2D.global_rotation = angle+deg_to_rad(180)


#Dummy function for player death: 
func player_dies(death_message: String) -> void: 
	print(death_message)
	if auto_respawn:
		position = respawn_point
	else:
		GlobalVariables.emit_game_over(death_message)



func _on_screen_exited():
	print("Player left camera area")
	if dies_on_screen_leave:
		GlobalVariables.emit_player_died("You left the mission area")
		
func _on_screen_entered():
	print("Player entered camera area")
