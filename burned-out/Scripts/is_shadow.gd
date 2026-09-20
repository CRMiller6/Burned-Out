class_name SunManager extends Node

@onready var sun_timer: Timer = $SunTimer
@onready var moon_timer: Timer = $MoonTimer

@onready var sun_animation: AnimationPlayer = $"../DirectionalLight3D/AnimationPlayer"
@onready var eclipse_sprite: AnimatedSprite3D = $"../eclipse"


@onready var audio: AudioStreamPlayer = $AudioStreamPlayer 
@onready var dummy_audio = AudioStreamPlayer.new()
var fading = false

static var is_sun_out: bool
static var is_player_hidden: bool

func _ready() -> void:
	is_sun_out = false
	moon_phase()
	
	add_child(dummy_audio)
	audio.stream = load("res://Assets/Music/Dead of Night.ogg")
	audio.play()
	
func _process(delta: float) -> void:
	if (fading):
		audio.volume_db -= 60 * delta
		dummy_audio.volume_db += 60 * delta
		
		if (dummy_audio.volume_db >= 0 ):
			audio.volume_db = 0
			dummy_audio.volume_db = -60
			audio.stream  = dummy_audio.stream
			audio.play(dummy_audio.get_playback_position())
			
			dummy_audio.stop()
			fading = false
	
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
	play_song("Dead of Night")
	moon_timer.start()

func sun_phase():
	print("here comes the sun.")
	is_sun_out = true
	sun_animation.play("RotateSun")
	eclipse_sprite.play("sun_phase")
	play_song("Ortis Solis")
	sun_timer.start()


func play_song(song_name) -> void:
	dummy_audio.stream = load("res://Assets/Music/" + song_name + ".ogg")
	dummy_audio.volume_db = -60
	dummy_audio.play()
	
	fading = true
