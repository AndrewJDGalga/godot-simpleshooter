extends Area2D

enum LASER_STATES {READY, FIRING, COOLING, LOCKED}

@onready var laser = $Laser
@onready var laser_timer = $PlayerLaserTimer

@export var laser_fill_rate= 50.0
@export var laser_empty_rate = 50.0
@export var laser_empty_rate_punished = 20.0
@export var laser_cooldown = 300

var current_laser_state:LASER_STATES = LASER_STATES.READY

func _physics_process(delta):
	firing_states(delta)

func firing_states(dt):
	match current_laser_state:
		LASER_STATES.READY:
			if Input.is_action_pressed("fire_laser"):
				current_laser_state = LASER_STATES.FIRING
		LASER_STATES.FIRING:
			if laser_timer.is_overheated():
				current_laser_state = LASER_STATES.LOCKED
			if Input.is_action_pressed("fire_laser"):
				laser_timer.increaseFill(dt, laser_fill_rate)
			if Input.is_action_just_released("fire_laser"):
				current_laser_state = LASER_STATES.COOLING
		LASER_STATES.COOLING:
			laser_timer.decreaseFill(dt, laser_empty_rate)
			if laser_timer.is_cool():
				current_laser_state = LASER_STATES.READY
		LASER_STATES.LOCKED:
			laser_timer.decreaseFill(dt, laser_empty_rate_punished)
			if laser_timer.is_cool():
				current_laser_state = LASER_STATES.READY
