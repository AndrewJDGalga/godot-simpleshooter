extends Area2D

@export_group("Movement")
@onready var sprite = $PlayerShip
@onready var sprite_thrusters = $PlayerThrusters
@export var speed := Vector2(40,10)
@export var speed_limit := Vector2(8, 5)
@export var speed_rotate := 2.0
@export var sprite_size := Vector2(8,32)
var velocity:Vector2
var screen_limit:Vector2
var top_limit:int
var bottom_limit:int
var left_limit:int
var right_limit:int

@export_group("Laser")
enum LASER_STATES {READY, FIRING, COOLING, LOCKED}
@onready var laser = $Laser
var current_laser_state:LASER_STATES = LASER_STATES.READY

@export_subgroup("Laser Timer")
@onready var laser_timer = $PlayerLaserTimer
@export var laser_fill_rate= 50.0
@export var laser_empty_rate = 50.0
@export var laser_empty_rate_punished = 20.0
@export var laser_cooldown = 300

func _ready():
	screen_limit = Vector2( \
		ProjectSettings.get_setting("display/window/size/viewport_width"), \
		ProjectSettings.get_setting("display/window/size/viewport_height"))
	top_limit = -screen_limit.y/2 + sprite_size.y/2
	bottom_limit = screen_limit.y/2 - sprite_size.y/2
	left_limit = -screen_limit.x/2 + sprite_size.x/2
	right_limit = screen_limit.x/2 - sprite_size.x/2
	
	laser_timer.visible = false
	sprite_thrusters.visible = false

func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "down", "up")
	rotate(input_dir.x * delta * speed_rotate)
	move(input_dir.y, delta)
	move_animation(input_dir)
	screen_wrap()
	firing_states(delta)

func screen_wrap():
	if position.x < left_limit:
		position.x = right_limit
	if position.x > right_limit:
		position.x = left_limit
	if position.y < top_limit:
		position.y = bottom_limit
	if position.y > bottom_limit:
		position.y = top_limit

func move_animation(input):
	sprite_thrusters.visible = false
	if input.x > 0:
		sprite_thrusters.frame = 1
	if input.x < 0:
		sprite_thrusters.frame = 0
	if input.y > 0:
		sprite_thrusters.frame = 3
	if input.y < 0:
		sprite_thrusters.frame = 2
	
	if input:
		sprite_thrusters.visible = true


func move(input_y, dt):
	velocity += input_y * Vector2.UP.rotated(rotation) * speed * dt
	velocity = velocity.clamp(-speed_limit, speed_limit)
	position += velocity

func firing_states(dt):
	match current_laser_state:
		LASER_STATES.READY:
			firing_state_ready()
		LASER_STATES.FIRING:
			firing_state_firing(dt)
		LASER_STATES.COOLING:
			firing_state_cooling(dt)
		LASER_STATES.LOCKED:
			firing_state_locked(dt)

func firing_state_ready():
	laser_timer.visible = false
	if Input.is_action_just_pressed("fire_laser"):
		laser_timer.visible = true
		current_laser_state = LASER_STATES.FIRING
func firing_state_firing(dt):
	if Input.is_action_pressed("fire_laser"):
		laser_timer.increaseFill(dt, laser_fill_rate)
		laser.enable_laser()
	if Input.is_action_just_released("fire_laser"):
		laser.disable_laser()
		current_laser_state = LASER_STATES.COOLING
	if laser_timer.is_overheated():
		laser.disable_laser()
		current_laser_state = LASER_STATES.LOCKED
func firing_state_cooling(dt):
	laser_timer.decreaseFill(dt, laser_empty_rate)
	if laser_timer.is_cool():
		current_laser_state = LASER_STATES.READY
func firing_state_locked(dt):
	laser_timer.decreaseFill(dt, laser_empty_rate_punished)
	if laser_timer.is_cool():
		current_laser_state = LASER_STATES.READY
