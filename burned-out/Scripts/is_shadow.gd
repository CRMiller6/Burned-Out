class_name SunManager extends Node

@onready var sun_timer: Timer = $SunTimer
@onready var moon_timer: Timer = $MoonTimer

@onready var sun_animation: AnimationPlayer = $"../DirectionalLight3D/AnimationPlayer"


static var is_sun_out: bool
static var is_player_hidden: bool

func _ready() -> void:
	is_sun_out = false
	#for testing. Comment in normal gameplay
	moon_phase()
	
func button_trigger_method_wherever() -> void:
	sun_timer.stop()
	moon_timer.start()
	
func _on_sun_timer_timeout() -> void: #start moon timer
	moon_phase()

func _on_moon_timer_timeout() -> void: #start sun timer
	sun_phase()

func moon_phase():
	print("night time.")
	is_sun_out = false
	sun_animation.play_backwards("RotateSun")
	
	moon_timer.start()

func sun_phase():
	print("here comes the sun.")
	is_sun_out = true
	sun_animation.play("RotateSun")
	
	sun_timer.start()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
