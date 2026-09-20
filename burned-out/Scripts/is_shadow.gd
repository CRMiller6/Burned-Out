class_name SunManager extends Node

@onready var sun_timer: Timer = $SunTimer
@onready var moon_timer: Timer = $MoonTimer

@onready var sun: DirectionalLight3D = $"../DirectionalLight3D"
var sun_pos: Vector3 = Vector3(-16.2, -171, 128)
var sun_rot: Vector3 = Vector3(-16.2, -171, 128)
var moon_pos
var moon_rot: Vector3 = Vector3(1.6, 160, 121.5)

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
	#DirectionalLight3D.rotation = sun_rot
	
	moon_timer.start()

func sun_phase():
	print("here comes the sun.")
	is_sun_out = true
	DirectionalLight3D.rotation = sun_rot
	
	sun_timer.start()
