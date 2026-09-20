extends Label

var total_lives: int = 3
static var current_lives: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_lives = total_lives
	text = ("Lives Left: x" + str(total_lives))
	
func minus_life():
	current_lives -= 1
	text = ("Lives Left: x" + str(total_lives))
	if (current_lives <= 0):
		pass
		#death screen
