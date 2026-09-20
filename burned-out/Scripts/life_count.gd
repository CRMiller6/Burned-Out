extends Label

var total_lives: int = 3
@onready var dead_menu: MarginContainer = %DeathMenu
#@onready var menu_ui = $MenuManager
#@onready var dead_menu = menu_ui.find_child("DeathMenu")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#dead_menu.visible = false
	total_lives = Life_Countdown.current_lives
	text = ("Lives Left: x" + str(total_lives))
	if Life_Countdown.current_lives <= 0:
		%DeathMenu.visible = true

func _on_texture_progress_bar_minus_life() -> void:
	print("died!")
	Life_Countdown.current_lives -= 1
	var life_count = Life_Countdown.current_lives
	text = ("Lives Left: x" + str(total_lives))
	if (life_count <= 0):
		print("helpldspsps")
		%DeathMenu.visible = true
		
		if dead_menu.visible == true:
			print("sjklfdnjalkdfjdsjfk")
		
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#death screen
