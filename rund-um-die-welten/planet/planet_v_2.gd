extends Area2D

@export var size_scale := 1.0  # Standardgröße (1 = 100%)

# for differentiating different planets
@export var planet_type: GlobalVariables.planets

@export var win_planet = false

@export var win_message = "You reached the goal"

@export var death_message_overwrite: String

@export var speed = 300

@export var clockwise = true

@export var collision_enabled = true
func _ready():
	var shape = $CollisionShape2D.shape
	# Sprite skalieren falls notwendig?
	#$Sprite2D.scale = Vector2(size_scale, size_scale)
	
	# Collision anpassen (wenn z. B. CircleShape2D)
	# Reaktion auf Klick
	input_pickable = true
	
	# change size of collision area and animation based on which planet is chosen
	match planet_type:
		GlobalVariables.planets.DeathStar:
			size_scale = 1.5
			$death_star.play("default")
			$death_star.visible = true
		GlobalVariables.planets.Mars:
			size_scale = 1.5
			$mars.play("default")
			$mars.visible = true
		GlobalVariables.planets.Earth:
			size_scale = 4.2
			$earth.play("default")
			$earth.visible = true
		GlobalVariables.planets.Sun:
			size_scale = 4.8
			$sun.play("default")
			$sun.visible = true
	
	shape.radius *= size_scale
		
		
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		GlobalVariables.target_planet_position = position
		GlobalVariables.player_speed = speed
		GlobalVariables.player_clockwise = clockwise


func _on_area_entered(area: Area2D) -> void:
	if collision_enabled:
		# if area in player group entered, kill player
		if area.is_in_group("player"):
			if win_planet:
				GlobalVariables.emit_level_done(win_message)
			else:
				if death_message_overwrite:
					GlobalVariables.emit_player_died(death_message_overwrite)
				else:
					GlobalVariables.emit_player_died("You crashed into the " + GlobalVariables.planet_names[planet_type])
				print(area.position)
		
