extends Node

@onready var sun_timer: Timer = $SunTimer
@onready var moon_timer: Timer = $MoonTimer

static var is_sun_out: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_sun_out = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func button_trigger_method_wherever() -> void:
	sun_timer.stop()
	moon_timer.start()
	
func _on_sun_timer_timeout() -> void:
	moon_timer.start()
	is_sun_out = false


func _on_moon_timer_timeout() -> void:
	sun_timer.start()
	is_sun_out = true
