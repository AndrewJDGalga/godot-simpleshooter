extends Player

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
	#side_limit = -screen_limit.x/2 + sprite.size.y/2
	left_limit = -screen_limit.x/2 + sprite.size.y/2
	right_limit = screen_limit.x/2 - sprite.size.y/2

func _physics_process(delta):
	movement(delta)
	laserHandler()
	
	if Input.is_action_just_pressed("fire_missile"):
		pass

func movement(dt):
	global_position.x = clamp(position.x, left_limit, right_limit)
	global_position.y = clamp(position.y, top_limit, bottom_limit)
	var dir = Vector2(Input.get_action_strength("right") - \
	Input.get_action_strength("left"), Input.get_action_strength("down") - \
	Input.get_action_strength("up"))
	velocity = move_speed * dir * dt
	move_and_collide(velocity)
	#position.clamp(-screen_limit, screen_limit)
	#print(position)
