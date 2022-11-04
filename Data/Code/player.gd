extends KinematicBody2D

const MAX_SPEED = 250
const ACCELERATION = 25
const GRAVITY = 20
const MAX_GRAVITY = 500
const JUMP_FORCE = 600

onready var camAnim = $Camera2D/Tween

var air_timer = 0
var friction = false
var movement = Vector2()

func _process(delta):
	movement.y = min(movement.y + GRAVITY * (delta*60), MAX_GRAVITY)
	
	if Input.is_action_pressed("ui_right"):
		friction = false
		movement.x = min(movement.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		friction = false
		movement.x = max(movement.x - ACCELERATION, -MAX_SPEED)
	else:
		friction = true
	
	if Input.is_action_just_pressed("jump") and air_timer < 7:
		movement.y = -JUMP_FORCE
	if Input.is_action_just_released("jump"):
		movement.y = max(movement.y * 0.7, movement.y)
	
	if is_on_floor():
		air_timer = 0
		if friction:
			movement.x = lerp(movement.x, 0, 0.06)
	else:
		air_timer += 1
		if friction:
			movement.x = lerp(movement.x, 0, 0.07)
	
	movement = move_and_slide(movement, Vector2.UP)


func cam_zoomin():
	camAnim.interpolate_property($Camera2D, "zoom", Vector2(1, 1), Vector2(0.25, 0.25), 0.75, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	camAnim.start()
