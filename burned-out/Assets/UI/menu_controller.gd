extends Control

var scene_path_to_load
@export var pause_menu: MarginContainer

@export var start_menu: MarginContainer

func _ready() -> void:
	if get_tree().current_scene.scene_file_path == "res://Scenes/Levels/testing_greybox.tscn":
		start_menu.visible = false

func _process(_delta: float) -> void:
		pass
	
func toggle_visibility(object):
	if object.visible:
		object.visible = false
	else:
		object.visible = true

func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_button_pressed() -> void:
	if get_tree().current_scene.scene_file_path == "res://Scenes/Levels/testing_greybox.tscn":
		toggle_visibility(start_menu)
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/testing_greybox.tscn")

func _on_button_return_pressed() -> void:
	toggle_visibility(pause_menu)
	
func _input(event):
	if event.is_action_pressed("Pause"):
		toggle_visibility(pause_menu)
