extends TextureProgressBar

@onready var sun_manager:Node3D = $"../../../SunManager"

@export var max_health: int = 1000
@export var current_health: float
var sun_burn: float = 2

signal reset_sun()

func _ready():
	current_health = max_health
	texture_progress = load("res://Assets/UI/EyeoftheEclipse_BlueHPBar.png")
	
func _process(_delta: float) -> void:
	value = current_health * 100 / max_health
	
	if (!SunManager.is_player_hidden && SunManager.is_sun_out):
		current_health -= sun_burn
		texture_progress = load("res://Assets/UI/EyeoftheEclipse_RedHPBar.png")
	
	if (!SunManager.is_player_hidden && !SunManager.is_sun_out && current_health != max_health):
		current_health += 0.8
		texture_progress = load("res://Assets/UI/EyeoftheEclipse_BlueHPBar.png")
	
	if (current_health <= 0):
		#respawn player
		reset_sun.emit()
	
