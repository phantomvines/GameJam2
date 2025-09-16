extends Area2D

@export var size_scale := 1.0  # Standardgröße (1 = 100%)

# for differentiating different planets
# 0 -> death star
# 1 -> mars
@export var planet_type: GlobalVariables.planets

@export var win_planet = false

@export var win_message = "You reached the goal"

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
			size_scale = 1.0
			$death_star.play("default")
			$death_star.visible = true
		GlobalVariables.planets.Mars:
			size_scale = 1.0
			$mars.play("default")
			$mars.visible = true
		GlobalVariables.planets.Earth:
			size_scale = 2.8
			$earth.play("default")
			$earth.visible = true
		GlobalVariables.planets.Sun:
			size_scale = 3.2
			$sun.play("default")
			$sun.visible = true
	
	shape.radius *= size_scale
		
		
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		GlobalVariables.target_planet_position = position


func _on_area_entered(area: Area2D) -> void:
	# if area in player group entered, kill player
	if area.is_in_group("player"):
		if win_planet:
			print("win")
			GlobalVariables.emit_level_done(win_message)
		else:
			GlobalVariables.emit_player_died("You crashed into the " + GlobalVariables.planet_names[planet_type])
			print("death")
			print(area.position)
		
