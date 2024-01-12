extends Area2D

enum LASER_STATES {READY, FIRING, COOLING, LOCKED}

@onready var laser = $Laser
@onready var laser_timer = $PlayerLaserTimer

@export var laser_fill_rate= 50.0
@export var laser_cooldown = 300

var normal_cooldown = false
var lock_cooldown = false

var current_laser_state:LASER_STATES = LASER_STATES.READY

func _physics_process(delta):
	match current_laser_state:
		LASER_STATES.READY:
			if Input.is_action_pressed("fire_laser"):
				current_laser_state = LASER_STATES.FIRING
		LASER_STATES.FIRING:
			if laser_timer.is_overheated():
				current_laser_state = LASER_STATES.LOCKED
			if Input.is_action_pressed("fire_laser"):
				laser_timer.increaseFill(delta, 50.0)
			if Input.is_action_just_released("fire_laser"):
				current_laser_state = LASER_STATES.COOLING
		LASER_STATES.COOLING:
			laser_timer.decreaseFill(delta, 50.0)
			if laser_timer.is_cool():
				current_laser_state = LASER_STATES.READY
		LASER_STATES.LOCKED:
			laser_timer.decreaseFill(delta, 20.0)
			if laser_timer.is_cool():
				current_laser_state = LASER_STATES.READY
	
	#if Input.is_action_pressed("fire_laser") && !lock_cooldown:
		#laser_timer.increaseFill(delta, 50.0)
		#normal_cooldown = false
	#if Input.is_action_just_released("fire_laser") && !lock_cooldown:
		#normal_cooldown = true
	#if laser_timer.is_overheated():
		#lock_cooldown = true
	#
	#if normal_cooldown:
		#laser_timer.decreaseFill(delta, 50.0)
	#if lock_cooldown:
		#laser_timer.decreaseFill(delta, 20.0)
	#
	#if laser_timer.is_cool():
		#normal_cooldown = false
		#lock_cooldown = false
	
	#else:
		#laser_timer.decreaseFill(delta)
	
	#else:
		#laser_timer.decreaseFill(delta)
	#if laser_timer.is_overheat():
		#cooldown = true
	#if cooldown:
		#cooldown_timer.increaseFill(delta)
		#if cooldown_timer.is_overheat():
			#cooldown = false
			#cooldown_timer.reset_fill()  
