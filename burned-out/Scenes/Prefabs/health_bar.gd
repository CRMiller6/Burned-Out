extends TextureProgressBar

@onready var sun_manager:Node3D = $"../../../SunManager"

@export var max_health: int = 1000
@export var current_health: int
var sun_burn: float = 2

func _ready():
	current_health = max_health

	
func _process(delta: float) -> void:
	value = current_health * 100 / max_health
	
	if (!SunManager.is_player_hidden && SunManager.is_sun_out):
		current_health -= sun_burn
	
	if (!SunManager.is_player_hidden && !SunManager.is_sun_out && current_health != max_health):
		current_health += 0.6
