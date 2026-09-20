extends Label

var total_lives: int = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_lives = Life_Countdown.current_lives
	text = ("Lives Left: x" + str(total_lives))

func _on_texture_progress_bar_minus_life() -> void:
	print("died!")
	Life_Countdown.current_lives -= 1
	text = ("Lives Left: x" + str(total_lives))
	if (Life_Countdown.current_lives <= 0):
		pass
		#death screen
