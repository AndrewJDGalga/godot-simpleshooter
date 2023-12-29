extends Player

@export var speed = Vector2(40,10)
@export var border_recovery = 80.0
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
	#move_frictionless()
	#lock_to_screen()
	
	move()
	rot(delta)
	
	laserHandler()
	
	#move_and_collide(velocity * delta)

func wrap_screen():
	pass

func lock_to_screen():
	if global_position.x < left_limit:
		velocity.x = -border_recovery
		global_position.x = right_limit
	if global_position.x > right_limit:
		velocity.x = border_recovery
		global_position.x = left_limit
	if global_position.y < top_limit:
		velocity.y = -border_recovery
		global_position.y = bottom_limit
	if global_position.y > bottom_limit:
		velocity.y = border_recovery
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

var dir = 0
var rot_dir = 0

func move():
	velocity += Input.get_axis("down", "up") * Vector2.UP.rotated(rotation) * 5
	velocity = velocity.clamp(Vector2(-50,-50), Vector2(50,50))
	
	print(velocity)
	#if Input.is_action_pressed("up"):
		#velocity = global_position.rotated(rotation)
		#velocity += Vector2.UP.rotated(rotation) * 50
	#if Input.is_action_pressed("down"):
		#velocity -= Vector2.UP.rotated(rotation) * 50
	move_and_slide()
	#if Input.is_action_pressed("up"):
		#pass
	#if Input.is_action_pressed("down"):
		#pass

func rot(dt):
	rot_dir = Input.get_axis("left", "right")
	rotate(rot_dir * dt * 2)
	#velocity.rotated()
	#if Input.is_action_pressed("left"):
		#pass
	#if Input.is_action_pressed("right"):
		#pass
