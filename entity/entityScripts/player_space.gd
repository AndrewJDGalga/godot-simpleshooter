extends Player

@export var boost_speed = 200.0
var screen_limit:Vector2 = Vector2.ZERO
var sprite = null
var top_limit = 0
var bottom_limit = 0
var side_limit = 0
var left_limit = 0
var right_limit = 0

func _ready():
	screen_limit = Vector2( \
		ProjectSettings.get_setting("display/window/size/viewport_width"), \
		ProjectSettings.get_setting("display/window/size/viewport_height"))
	sprite = $temp_vid_bod
	top_limit = -screen_limit.y + sprite.size.y * 2
	bottom_limit = sprite.size.y/2
	left_limit = -screen_limit.x/2 + sprite.size.y/2
	right_limit = screen_limit.x/2 - sprite.size.y/2
	laser = $player_laser

func _physics_process(delta):
	lock_to_screen()
	movement(delta)
	laserHandler()
	boost_left()
	boost_right()
	
	move_and_collide(velocity)

func lock_to_screen():
	global_position.x = clamp(position.x, left_limit, right_limit)
	global_position.y = clamp(position.y, top_limit, bottom_limit)

func movement(dt):
	var dir = Vector2(Input.get_action_strength("right") - \
	Input.get_action_strength("left"), Input.get_action_strength("down") - \
	Input.get_action_strength("up"))
	dir = dir.normalized()
	velocity = move_speed * dir * dt

func boost_left():
	if Input.is_action_just_pressed("boost_left"):
		velocity.x -= boost_speed
		print(velocity)

func boost_right():
	if Input.is_action_just_pressed("boost_right"):
		velocity.x += boost_speed
