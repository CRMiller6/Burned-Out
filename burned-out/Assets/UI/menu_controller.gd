extends Control

var scene_path_to_load
@export var pause_menu: MarginContainer
@export var dead_menu: MarginContainer

#@export var health_bar: CanvasLayer
#var curent_health = health_bar.current_health

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	#if curent_health <= 0:
		#toggle_visibility(dead_menu)
		pass
	
func toggle_visibility(object):
	if object.visible:
		object.visible = false
	else:
		object.visible = true

func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/testing_greybox.tscn")

func _on_button_return_pressed() -> void:
	toggle_visibility(pause_menu)
	
func _input(event):
	if event.is_action_pressed("Pause"):
		toggle_visibility(pause_menu)
