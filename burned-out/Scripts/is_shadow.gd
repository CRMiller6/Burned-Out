class_name SunManager extends Node

@onready var sun_timer: Timer = $SunTimer
@onready var moon_timer: Timer = $MoonTimer

@onready var sun_animation: AnimationPlayer = $"../DirectionalLight3D/AnimationPlayer"
@onready var eclipse_sprite: AnimatedSprite3D = $"../eclipse"

static var is_sun_out: bool
static var is_player_hidden: bool

func _ready() -> void:
	is_sun_out = false
	#for testing. Comment in normal gameplay
	moon_phase()
	
func reset_phase() -> void:
	sun_timer.stop()
	moon_phase()
	
func _on_sun_timer_timeout() -> void: #start moon timer
	moon_phase()

func _on_moon_timer_timeout() -> void: #start sun timer
	sun_phase()

func moon_phase():
	print("night time.")
	is_sun_out = false
	sun_animation.play_backwards("RotateSun")
	eclipse_sprite.play("moon_phase")
	
	moon_timer.start()

func sun_phase():
	print("here comes the sun.")
	is_sun_out = true
	sun_animation.play("RotateSun")
	eclipse_sprite.play("sun_phase")
	
	sun_timer.start()
