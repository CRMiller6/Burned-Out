extends CharacterBody3D


@export var speed: int  = 8
@export var acceleration: int = 2
@export var gravity: int = speed * 5
var jump_speed: float = speed * 1.5

enum State{IDLE, WALK, JUMP, DOWN}
var current_state: State = State.IDLE

func _physics_process(delta: float) -> void:
	handle_input()
	update_movement(delta)
	update_states()
	move_and_slide()
	
func handle_input() -> void:
	if (Input.is_action_just_pressed("jump") and is_on_floor()):
		velocity.y = jump_speed
		current_state = State.JUMP
	
	var direction = Input.get_axis("walk_left", "walk_right")
	
	if (direction == 0):
		velocity.x = move_toward(velocity.x, 0, acceleration) #delecerate to stop
	else:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration) #acceleration
		
func update_movement(delta: float) -> void:
	velocity.y -= gravity * delta

func update_states() -> void:
	match current_state:
		State.IDLE when velocity.x != 0:
			current_state = State.WALK
		State.WALK:
			if (velocity.x == 0):
				current_state = State.IDLE
			if (not is_on_floor() && velocity.y > 0):
				current_state = State.DOWN
		State.JUMP when velocity.y > 0:
			current_state = State.DOWN
		State.DOWN when is_on_floor():
			if velocity.x == 0:
				current_state = State.WALK
