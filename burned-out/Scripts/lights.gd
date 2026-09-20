extends Sprite3D

@onready var light: SpotLight3D = $SpotLight3D


func _process(delta: float) -> void:
	if (SunManager.is_sun_out):
		light.hide()
	else:
		light.show()
