extends Player

@export var speed_limit = Vector2(120, 30)
@export var speed = Vector2(40,10)
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
	move_frictionless()
	lock_to_screen()
	laserHandler()
	
	move_and_collide(velocity * delta)

func lock_to_screen():
	if global_position.x < left_limit:
		velocity.x = 0
		global_position.x += 1
	if global_position.x > right_limit:
		velocity.x = 0
		global_position.x -= 1
	if global_position.y < top_limit:
		velocity.y = 0
		global_position.y += 1
	if global_position.y > bottom_limit:
		velocity.y = 0
		global_position.y -= 1

func move_frictionless():
	if Input.is_action_pressed("left"):
		velocity.x -= speed.x
	if Input.is_action_pressed("right"):
		velocity.x += speed.x
	clamp(velocity.x, -speed_limit.x, speed_limit.x)
	if Input.is_action_pressed("up"):
		velocity.y -= speed.y
	if Input.is_action_pressed("down"):
		velocity.y += speed.y
	clamp(velocity.y, -speed_limit.y, speed_limit.y)
