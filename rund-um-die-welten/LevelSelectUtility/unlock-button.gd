extends Button

@export var threshold = 0
var unlocked = false
@export var skin = "default" #enterpise, x-wing

#find number of collectables
func _ready():
	check_unlock()
	update_icon()
	update_text()
	connect("pressed", Callable(self, "_on_pressed"))

func check_unlock():
	var total = 0
	for level in GlobalVariables.collectibles.keys():
		for value in GlobalVariables.collectibles[level]:
			total += value
	total += 30
	if total >= threshold:
		unlocked = true
		disabled = false
	else:
		unlocked = false
		disabled = true

func _on_pressed():
	if unlocked:
		GlobalVariables.player_skin = skin

func update_icon():
	match skin:
		"default":
			icon = load_scaled_icon("res://assets/rocket1.png")
		"x-wing":
			icon = load_scaled_icon("res://assets/x-wing1.png")
		"enterprise":
			icon = load_scaled_icon("res://assets/enterprise1.png")
		"falcon":
			icon = load_scaled_icon("res://assets/falcon1.png")
		_:
			icon = null

func load_scaled_icon(path: String) -> Texture2D:
	var scale = 4
	var img = load(path).get_image()
	img.resize(img.get_width() * scale, img.get_height() * scale, Image.INTERPOLATE_NEAREST)
	var tex = ImageTexture.create_from_image(img)
	return tex

func update_text():
	text = str(threshold)
	if threshold < 9:
		text = "0" + text
	add_theme_font_size_override("font_size", 60)
