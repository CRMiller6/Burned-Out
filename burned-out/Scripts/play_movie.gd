extends Area3D

@onready var current_scene: Node3D = $"../../../.."


func _on_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://Scenes/Prefabs/video.tscn")
	current_scene.queue_free()
