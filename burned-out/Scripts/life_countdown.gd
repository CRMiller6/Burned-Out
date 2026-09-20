class_name Life_Countdown extends Node

static var total_lives: int = 3
static var current_lives: int

func _ready() -> void:	
	current_lives = total_lives


func _process(_delta: float) -> void:
	pass
	#see if current scene is main menu
		#if main menu, total lives = 3
