extends Area2D

# angle
@export var spawn_rotation = 0
@export var dies_on_screen_leave = false
@export var respawn_point: Vector2
@export var auto_respawn = false

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)
	$VisibleOnScreenNotifier2D.screen_entered.connect(_on_screen_entered)
	GlobalVariables.player_died.connect(player_dies)
	rotation = spawn_rotation
	
func _physics_process(delta: float) -> void:
	if(GlobalVariables.target_planet_position):
		# calculate movement
		var radius = position.distance_to(GlobalVariables.target_planet_position)
		var angle = (position-GlobalVariables.target_planet_position).angle()
		
		var angular_speed = GlobalVariables.player_speed/radius
		
		if GlobalVariables.player_clockwise:
			angle += angular_speed*delta
		else:
			angle -= angular_speed*delta
		
		position = GlobalVariables.target_planet_position+Vector2(cos(angle), sin(angle))*radius
		
		#print(angle)
		rotation = angle + deg_to_rad(180)

		if GlobalVariables.player_clockwise:
			rotation = angle + deg_to_rad(180)
		else:
			rotation = angle

#Dummy function for player death: 
func player_dies(death_message: String) -> void: 
	print("hi")
	print(death_message)
	if auto_respawn:
		position = respawn_point
	elif(GlobalVariables.target_planet_position):
		GlobalVariables.emit_game_over(death_message)



func _on_screen_exited():
	print("Player left camera area")
	if dies_on_screen_leave:
		GlobalVariables.emit_player_died("You left the mission area")
		
func _on_screen_entered():
	print("Player entered camera area")
