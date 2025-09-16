extends CanvasLayer

@onready var death_screen = $DeathScreen
@onready var pause_menu = $PauseMenu

func _ready():
	death_screen.visible = false
	pause_menu.visible = false

# === Death Screen ===
func show_death_screen(game_over_message):
	death_screen.change_death_message(game_over_message)
	death_screen.visible = true
	get_tree().paused = true  # Pause the game
	# Optional: Play sound or animation

func hide_death_screen():
	death_screen.visible = false
	get_tree().paused = false

# === Pause Menu ===
func toggle_pause():
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	pause_menu.visible = !is_paused
