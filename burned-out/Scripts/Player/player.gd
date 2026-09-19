extends CharacterBody3D


@export var speed: int  = 8
@export var acceleration: int = 2
var gravity: int = speed * 3
@export var jump_speed_multiplier: float = 1.8
var jump_speed: float = speed * jump_speed_multiplier
@export var down_gravity_factor: float = 1.5

@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var camera_controller: Node3D = $CameraController

enum State{IDLE, WALK, JUMP, DOWN}
var current_state: State = State.IDLE

func _physics_process(delta: float) -> void:
	handle_input()
	update_movement(delta)
	update_states()
	move_and_slide()
	camera_follow()
	

func handle_input() -> void:
	if (Input.is_action_just_pressed("jump")):
		jump_buffer_timer.start()
	
	var direction = Input.get_axis("walk_left", "walk_right")
	
	if (direction == 0):
		velocity.x = move_toward(velocity.x, 0, acceleration) #delecerate to stop
	else:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration) #acceleration
		
func update_movement(delta: float) -> void:
	if ((is_on_floor() || coyote_timer.time_left > 0) && jump_buffer_timer.time_left > 0):
		velocity.y = jump_speed
		current_state = State.JUMP
		jump_buffer_timer.stop()
		coyote_timer.stop()
	
	if (current_state == State.JUMP):
		velocity.y -= gravity * delta
	else:
		velocity.y -= gravity * down_gravity_factor * delta 

func update_states() -> void:
	match current_state:
		State.IDLE when velocity.x != 0:
			current_state = State.WALK
		State.WALK:
			if (velocity.x == 0):
				current_state = State.IDLE
			if (not is_on_floor() && velocity.y > 0):
				current_state = State.DOWN
				coyote_timer.start()
		State.JUMP when velocity.y > 0:
			current_state = State.DOWN
		State.DOWN when is_on_floor():
			if velocity.x == 0:
				current_state = State.WALK

func camera_follow():
	camera_controller.position = lerp(camera_controller.position, position, 0.15)
	
	
	
