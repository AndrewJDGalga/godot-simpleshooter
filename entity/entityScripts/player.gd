extends Area2D

@export_group("Movement")
@export var speed:float = 50.0

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


func _physics_process(delta):
	
	
	firing_states(delta)

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
	if Input.is_action_just_pressed("fire_laser"):
		current_laser_state = LASER_STATES.FIRING
func firing_state_firing(dt):
	if laser_timer.is_overheated():
		current_laser_state = LASER_STATES.LOCKED
	if Input.is_action_pressed("fire_laser"):
		laser_timer.increaseFill(dt, laser_fill_rate)
	if Input.is_action_just_released("fire_laser"):
		current_laser_state = LASER_STATES.COOLING
func firing_state_cooling(dt):
	laser_timer.decreaseFill(dt, laser_empty_rate)
	if laser_timer.is_cool():
		current_laser_state = LASER_STATES.READY
func firing_state_locked(dt):
	laser_timer.decreaseFill(dt, laser_empty_rate_punished)
	if laser_timer.is_cool():
		current_laser_state = LASER_STATES.READY
