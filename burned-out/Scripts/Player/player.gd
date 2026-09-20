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
@onready var wall_stick_timer: Timer = $WallStickTimer
#wall jump
@onready var wall_detect_top_left: RayCast3D = $RayCastTopLeft
@onready var wall_detect_bottom_left: RayCast3D = $RayCastBottomLeft
@onready var wall_detect_top_right: RayCast3D = $RayCastTopRight
@onready var wall_detect_bottom_right: RayCast3D = $RayCastBottomRight

@export var wall_jump_pushback: float = 4
@export var wall_slide: float = 10
var is_wall_clinging: bool
var is_wall_sliding: bool

#sprite
@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D
@onready var eclipse_sprite: AnimatedSprite3D = $"../eclipse"
@onready var camera_controller: Node3D = $CameraController

enum State{IDLE, WALK, JUMP, FALLING}
var current_state: State = State.IDLE

func _ready() -> void:
	var viewport_size = get_viewport().size
	eclipse_sprite.position = Vector3(viewport_size.x, viewport_size.y, -10) / 2
	
	var texture_size = eclipse_sprite.scale
	
	eclipse_sprite.scale.x = (viewport_size.x / texture_size.x)
	eclipse_sprite.scale.y = (viewport_size.y / texture_size.y)

func _physics_process(delta: float) -> void:
	handle_input()
	update_movement(delta)
	update_states()
	move_and_slide()
	handle_animation()
	camera_follow()
	
	#print("velocity.x: ", velocity.x, " velocity.y", velocity.y)
	#print("is on wall: ", is_on_wall(), "is wall sliding:")
	

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

#dtermine if sliding down wall or jumping off of wall
	if (current_state == State.JUMP):
		is_wall_clinging = false
		is_wall_sliding = false
		velocity.y -= gravity * delta #gravity when jumping
	elif (is_on_wall() && !is_on_floor()):
		is_wall_sliding = true
	elif (is_wall_clinging && !is_on_floor):
		is_wall_sliding = true
	else:
		is_wall_clinging = false
		is_wall_sliding = false
		velocity.y -= gravity * down_gravity_factor * delta #gravity when falling
	
	#wall cling
	if (is_wall_sliding):
		velocity.y -= wall_slide * delta
		velocity.y = min(velocity.y, wall_slide)
		#cling to wall
		if ((wall_detect_top_left.collide_with_bodies || wall_detect_bottom_left.collide_with_bodies) && is_wall_sliding):
			is_wall_clinging = true
			velocity.x -= wall_jump_pushback
					
		if ((wall_detect_top_right.collide_with_bodies || wall_detect_bottom_right.collide_with_bodies) && is_wall_sliding):
			is_wall_clinging = true
			velocity.x += wall_jump_pushback
	
	if (is_wall_clinging):
		#jump from wall
		if (jump_buffer_timer.time_left > 0):
			velocity.x = -velocity.x * 10

			velocity.y = jump_speed
			current_state = State.JUMP
			jump_buffer_timer.stop()
			coyote_timer.stop()

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
		State.JUMP when is_on_floor():			#switch from jump to fall
			current_state = State.WALK
		State.FALLING when is_on_floor():		#switch from falling to walk
			if velocity.x == 0:
				current_state = State.WALK

func handle_animation():
	match current_state:
		State.IDLE:
			sprite.play("Idle")
		State.WALK when velocity.x > 0:
			sprite.play("Walk")
			sprite.flip_h = false
		State.WALK when velocity.x < 0:
			sprite.play("Walk")
			sprite.flip_h = true
		State.JUMP:
			sprite.play("Jump")
		State.FALLING:
			sprite.play("Fall")

func camera_follow():
	camera_controller.position = lerp(camera_controller.position, position, 0.15)
	eclipse_sprite.position = Vector3(camera_controller.position.x, camera_controller.position.y, -10)
