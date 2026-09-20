class_name key extends Node3D

var is_hidden: bool
var is_lit: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_hidden = false
	is_lit = false
	
func _process(delta: float) -> void:
	if (SunManager.is_sun_out && is_hidden == true):
		is_lit = true
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body.Player && Player.is_coctail_grabbed == false):
		Player.is_coctail_grabbed = true
		
		if (is_lit):
			Player.is_key = true
		else:
			Player.is_key = false
