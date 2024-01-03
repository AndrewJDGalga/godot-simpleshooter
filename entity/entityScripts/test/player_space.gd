extends Player

@export var speed = Vector2(40,10)
@export var speed_limit = Vector2(200, 160)
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
	top_limit = -screen_limit.y/2 + sprite.size.y/2
	bottom_limit = screen_limit.y/2 - sprite.size.y/2
	left_limit = -screen_limit.x/2 + sprite.size.x/2
	right_limit = screen_limit.x/2 - sprite.size.x/2
	laser = $player_laser

func _physics_process(delta):
	wrap_screen()
	move()
	rot(delta)
	laserHandler()

func wrap_screen():
	if global_position.x < left_limit:
		global_position.x = right_limit
	if global_position.x > right_limit:
		global_position.x = left_limit
	if global_position.y < top_limit:
		global_position.y = bottom_limit
	if global_position.y > bottom_limit:
		global_position.y = top_limit

func move_frictionless():
	if Input.is_action_pressed("left"):
		velocity.x -= speed.x
	if Input.is_action_pressed("right"):
		velocity.x += speed.x
	if Input.is_action_pressed("up"):
		velocity.y -= speed.y
	if Input.is_action_pressed("down"):
		velocity.y += speed.y

func move():
	velocity += Input.get_axis("down", "up") * Vector2.UP.rotated(rotation) * speed
	velocity = velocity.clamp(-speed_limit, speed_limit)
	move_and_slide()

func rot(dt):
	rotate(Input.get_axis("left", "right") * dt * 2)
