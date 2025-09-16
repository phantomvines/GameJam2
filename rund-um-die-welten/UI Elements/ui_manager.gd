extends CanvasLayer

@onready var death_screen = $DeathScreen
@onready var pause_menu = $PauseMenu
@onready var win_screen = $WinScreen

func _ready():
	death_screen.visible = false
	pause_menu.visible = false
	win_screen.visible = false

# === Death Screen ===
func show_death_screen(game_over_message):
	death_screen.change_death_message(game_over_message)
	death_screen.visible = true
	get_tree().paused = true  # Pause the game
	# Optional: Play sound or animation

func hide_death_screen():
	death_screen.visible = false
	get_tree().paused = false


# === Win Screen ===
func show_win_screen(game_over_message):
	win_screen.change_death_message(game_over_message)
	win_screen.visible = true
	get_tree().paused = true  # Pause the game
	# Optional: Play sound or animation

func hide_win_screen():
	win_screen.visible = false
	get_tree().paused = false
	
	
# === Pause Menu ===
func toggle_pause():
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	pause_menu.visible = !is_paused
	
	
