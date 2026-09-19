extends CharacterBody3D

#walk direction
var direction: float
@export var speed: int  = 8
@export var acceleration: int = 2

#jump stuff
var gravity: int = speed * 3
@export var jump_speed_multiplier: float = 1.8
var jump_speed: float = speed * jump_speed_multiplier
@export var down_gravity_factor: float = 1.5

@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var coyote_timer: Timer = $CoyoteTimer

#wall jump
@export var wall_jump_pushback: float = 4
@export var wall_slide: float = 10
var is_wall_sliding: bool


@onready var camera_controller: Node3D = $CameraController

enum State{IDLE, WALK, JUMP, FALLING}
var current_state: State = State.IDLE

func _physics_process(delta: float) -> void:
	handle_input()
	update_movement(delta)
	update_states()
	move_and_slide()
	camera_follow()
	

func handle_input() -> void:
	#start jump timer
	if (Input.is_action_just_pressed("jump")): 
		jump_buffer_timer.start()
	
	#walk input
	direction = Input.get_axis("walk_left", "walk_right")
	
	if (direction == 0):
		velocity.x = move_toward(velocity.x, 0, acceleration) #delecerate to stop
	else:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration) #acceleration
	
		
func update_movement(delta: float) -> void:
	#start jump from floor
	if ((is_on_floor() || coyote_timer.time_left > 0) && jump_buffer_timer.time_left > 0):
		velocity.y = jump_speed 
		current_state = State.JUMP
		jump_buffer_timer.stop()
		coyote_timer.stop()
	
	#start jump from wall
	if (is_on_wall() && jump_buffer_timer.time_left > 0):
		velocity.y = jump_speed
		

	#wall cling
	if (is_on_wall()):
		if (direction < 0): #left
			velocity.x -= wall_jump_pushback
		elif (direction > 0): #right
			velocity.x += wall_jump_pushback
	
	#slide down wall
	if (current_state == State.JUMP):
		is_wall_sliding = false
		velocity.y -= gravity * delta #gravity when jumping
	elif (is_on_wall() && !is_on_floor()):
		if (direction != 0):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	
		if (is_wall_sliding):
			velocity.y -= wall_slide * delta
			velocity.y = min(velocity.y, wall_slide)
	else:
		is_wall_sliding = false
		velocity.y -= gravity * down_gravity_factor * delta #gravity when falling
		
	#wall slide
	#if (is_on_wall() && !is_on_floor()):
		#if (direction != 0):
			#is_wall_sliding = true
		#else:
			#is_wall_sliding = false
	#else:
		#is_wall_sliding = false
	#
	#if (is_wall_sliding):
		#velocity.y += wall_slide * delta
		#velocity.y = min(velocity.y, wall_slide)

func update_states() -> void:
	match current_state:
		State.IDLE when velocity.x != 0: 	#switch to walking from idle
			current_state = State.WALK
		State.WALK:							#switch  from walk to idle or falling
			if (velocity.x == 0):
				current_state = State.IDLE
			if (not is_on_floor() && velocity.y > 0):
				current_state = State.FALLING
				coyote_timer.start()
		State.JUMP when velocity.y > 0:			#switch from jump to fall
			current_state = State.FALLING
		State.FALLING when is_on_floor():		#switch from falling to walk
			if velocity.x == 0:
				current_state = State.WALK

func camera_follow():
	camera_controller.position = lerp(camera_controller.position, position, 0.15)	
	
