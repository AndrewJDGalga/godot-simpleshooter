extends Entity

@onready var laser = $Laser
@onready var laser_timer = $PlayerLaserTimer

#@onready var cooldown_timer = $PlayerCoolTimer

@export var laser_fill_rate= 50.0
@export var laser_cooldown = 300

var normal_cooldown = false
var lock_cooldown = false

#func _ready():
	#laser_timer.set_fill_rate(50)
	#cooldown_timer.set_fill_rate(laser_cooldown)

func _physics_process(delta):
	if Input.is_action_pressed("fire_laser") && !lock_cooldown:
		laser_timer.increaseFill(delta, 50.0)
		normal_cooldown = false
	if Input.is_action_just_released("fire_laser") && !lock_cooldown:
		normal_cooldown = true
	if laser_timer.is_overheated():
		lock_cooldown = true
	
	if normal_cooldown:
		laser_timer.decreaseFill(delta, 50.0)
	if lock_cooldown:
		laser_timer.decreaseFill(delta, 20.0)
	
	if laser_timer.is_cool():
		normal_cooldown = false
		lock_cooldown = false
	
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
