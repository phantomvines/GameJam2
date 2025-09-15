extends Area2D

var speed = 300
var direction = Vector2(1,0)

func _physics_process(delta: float) -> void:
	pass

func _ready() -> void:
	$AnimatedSprite2D.play()

func _on_area_entered(area: Area2D) -> void:
	# if area in player group entered, kill player
	if area.is_in_group("player"):
		print("death")
