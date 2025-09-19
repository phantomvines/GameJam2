extends Area2D

# angle
@export var spawn_rotation = 0
@export var dies_on_screen_leave = false
@export var respawn_point: Vector2
@export var auto_respawn = false

@export var center_boost_cooldown = 10
@export var center_boost_force = 200
@export var center_boost_duration = 1
# can player boost? 
var boostable = true
var boosting = false
@export var center_boost_disable = false

func _ready() -> void:
	$AnimatedSprite2D.play(GlobalVariables.player_skin)
	
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)
	$VisibleOnScreenNotifier2D.screen_entered.connect(_on_screen_entered)
	GlobalVariables.player_died.connect(player_dies)
	rotation = spawn_rotation
	
	# set boost cooldown
	$boost_cooldown.wait_time = center_boost_cooldown
	$boost_duration.wait_time = center_boost_duration
	
func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play(GlobalVariables.player_skin)
	if(GlobalVariables.target_planet_position):
		# calculate movement
		var radius = position.distance_to(GlobalVariables.target_planet_position)
		var angle = (position-GlobalVariables.target_planet_position).angle()
		
		var angular_speed = GlobalVariables.player_speed/radius
		
		if GlobalVariables.player_clockwise:
			angle += angular_speed*delta
		else:
			angle -= angular_speed*delta
			
		if Input.is_action_just_pressed("center_boost") and boostable and not center_boost_disable:
			boostable = false
			boosting = true
			$boost_duration.start()
			$boost_cooldown.start()
		
		if boosting:
			radius -= delta*center_boost_force
		
		position = GlobalVariables.target_planet_position+Vector2(cos(angle), sin(angle))*radius
		
		
		#print(angle)
		rotation = angle + deg_to_rad(180)
		
		if boosting:
			rotation *= 1.5

		if GlobalVariables.player_clockwise:
			rotation = angle + deg_to_rad(180)
			if boosting:
				rotation += 1
		else:
			rotation = angle
			if boosting:
				rotation -= 1
			

#Dummy function for player death: 
func player_dies(death_message: String) -> void: 
	print(death_message)
	$AnimatedSprite2D.visible = false
	$CPUParticles2D.emitting = false
	if auto_respawn:
		position = respawn_point
	elif(GlobalVariables.target_planet_position):
		add_child(load("res://player/death_animation.tscn").instantiate())
		GlobalVariables.emit_game_over(death_message)



func _on_screen_exited():
	if dies_on_screen_leave:
		GlobalVariables.emit_player_died("You left the mission area")
		
func _on_screen_entered():
	pass


func _on_boost_cooldown_timeout() -> void:
	boostable = true


func _on_boost_duration_timeout() -> void:
	boosting = false
