extends KinematicBody2D
class_name Player

const MAX_SPEED = 250
const ACCELERATION = 25
const GRAVITY = 20
const MAX_GRAVITY = 500
const JUMP_FORCE = 600

onready var camAnim = $Camera2D/Tween
onready var doorsroom = load("res://Data/Scenes/Game/doorsroom.tscn")

var air_timer = 0
var double_jump = false
var friction = false
var intangible = false
var dead = false
var movement = Vector2()

func _physics_process(delta):
	movement.y = min(movement.y + GRAVITY * (delta*60), MAX_GRAVITY)
	
	if Input.is_action_pressed("ui_right"):
		friction = false
		movement.x = min(movement.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		friction = false
		movement.x = max(movement.x - ACCELERATION, -MAX_SPEED)
	else:
		friction = true
	
	if Input.is_action_just_pressed("jump") and air_timer < 6:
		movement.y = -JUMP_FORCE
	if Input.is_action_just_pressed("jump") and air_timer >= 6 and not double_jump:
		movement.y = -JUMP_FORCE * 0.9
		double_jump = true
	if Input.is_action_just_released("jump"):
		movement.y = max(movement.y * 0.7, movement.y)
	
	if is_on_floor():
		air_timer = 0
		double_jump = false
		if friction:
			movement.x = lerp(movement.x, 0, 0.06)
	else:
		air_timer += 1
		if friction:
			movement.x = lerp(movement.x, 0, 0.07)
	
	if glob.health <= 0 and not dead:
		glob.health = 0
		dead = true
		glob.emit_signal("transition")
		yield(get_tree().create_timer(1), "timeout")
		glob.health = glob.maxHealth
		get_tree().change_scene_to(doorsroom)
	
	movement = move_and_slide(movement, Vector2.UP)


func cam_zoomin():
	camAnim.interpolate_property($Camera2D, "zoom", Vector2(1, 1), Vector2(0.25, 0.25), 0.75, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	camAnim.start()

func intangibility():
	intangible = true
	$Effects.play("hurted")
	yield(get_tree().create_timer(1), "timeout")
	intangible = false
	$Effects.stop()
	self.modulate = Color8(255, 255, 255)
