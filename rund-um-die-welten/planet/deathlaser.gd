extends Node2D

@export var rotation_speed_in_deg_per_second = 100
@export var laser_color = "pink":
	set(value):
		laser_color = value
		station_name = "State"+str(value).capitalize()
@export var death_message_overwrite: String
@export var clockwise = true
var active
var station_name:
	set(value):
		station_name = value
		for i in ["StateOrange", "StatePink", "StateGreen"]:
			get_node(i).visible = false
		get_node(station_name).visible = true

func _ready() -> void:
	$"HitboxStation".area_entered.connect(_on_station_area_entered)
	$"HitboxLaser1".area_entered.connect(_on_laser_area_entered)
	$"HitboxLaser2".area_entered.connect(_on_laser_area_entered)
	GlobalVariables.button_changed_stage.connect(check_state)
	station_name = "State"+str(laser_color).capitalize()
	check_state()
	
func check_state():
	change_laser_state_to(!GlobalVariables.active_buttons[laser_color])
	
func change_laser_state_to(state:bool):
	active = state
	for i in ["StateOrange", "StatePink", "StateGreen"]:
		get_node(i + "/LaserSprite1").visible = false	
		get_node(i + "/LaserSprite1").visible = false	
		get_node(i + "/StationSprite").visible = false
	get_node(station_name + "/StationSprite").visible = true
	get_node(station_name + "/LaserSprite1").visible = active
	get_node(station_name + "/LaserSprite2").visible = active

	

func toggle_laser():
	active = !active
	for i in ["StateOrange", "StatePink", "StateGreen"]:
		get_node(i + "/LaserSprite1").visible = false	
		get_node(i + "/LaserSprite1").visible = false	
	get_node(station_name + "/LaserSprite1").visible = true

func _physics_process(delta: float) -> void:
	if clockwise:
		rotate(deg_to_rad(rotation_speed_in_deg_per_second * delta))
	else:
		rotate(deg_to_rad(rotation_speed_in_deg_per_second * -delta))


func _on_laser_area_entered(area: Area2D) -> void:
	if active:
		# if area in player group entered, kill player
		if area.is_in_group("player"):
			if death_message_overwrite:
				GlobalVariables.emit_player_died(death_message_overwrite)
			else:
				GlobalVariables.emit_player_died("You crashed into an active " + str(laser_color) + " Laser")
			print(area.position)
		
func _on_station_area_entered(area: Area2D) -> void:
	# if area in player group entered, kill player
	if area.is_in_group("player"):
		if death_message_overwrite:
			GlobalVariables.emit_player_died(death_message_overwrite)
		else:
			GlobalVariables.emit_player_died("You crashed into the " + str(laser_color) + " Station")
		print(area.position)
