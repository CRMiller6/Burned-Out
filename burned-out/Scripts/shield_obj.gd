extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if(body.is_in_group("Player")):
		SunManager.is_player_hidden = true
		print("player in shield")


func _on_body_exited(body: Node3D) -> void:
	if(body.is_in_group("Player")):
		SunManager.is_player_hidden = false
		print("player left shield")
