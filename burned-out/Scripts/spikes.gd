extends CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node3D) -> void:
	if(body.is_in_group("Player")):
		SunManager.is_player_hidden = false


func _on_body_exited(body: Node3D) -> void:
	if(body.is_in_group("Player")):
		SunManager.is_player_hidden = false
