extends KinematicBody2D
class_name Player

const MAX_SPEED = 230
const ACCELERATION = 25
const GRAVITY = 23

const MAX_GRAVITY = 500
const JUMP_FORCE = 600

var air_timer = 0
var jump_remember = 0
var friction = false
var intangible = false
var dead = false
var movement = Vector2()

onready var animtree = $AnimationTree
onready var camAnim = $Camera2D/Tween
onready var doorsroom = load("res://Data/Scenes/Game/doorsroom.tscn")

func _ready():
	if glob.playersave['save_pos']:
		global_position = glob.playersave['position']
		glob.playersave['save_pos'] = false

func _physics_process(delta):
	
	movement.y = min(movement.y + GRAVITY * (delta*60), MAX_GRAVITY)
	
	if not glob.talking:
		animtree.set('parameters/GroundAction/current', movement.length() > 80)
		animtree.set('parameters/AirAction/current', movement.y > 0)
		
		if Input.is_action_pressed("ui_right"):
			friction = false
			movement.x = min(movement.x + ACCELERATION, MAX_SPEED)
			$Playersheet.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			friction = false
			movement.x = max(movement.x - ACCELERATION, -MAX_SPEED)
			$Playersheet.flip_h = true
		else:
			friction = true
		
		if Input.is_action_just_pressed("jump"):
			jump_remember = 2
		if Input.is_action_just_released("jump"):
			movement.y = max(movement.y * 0.7, movement.y)
		
		if air_timer > 0 and jump_remember > 0:
			air_timer = 0
			jump_remember = 0
			movement.y = -JUMP_FORCE
			
	else:
		movement.x = lerp(movement.x, 0, 0.1)
	
	if is_on_floor():
		air_timer = 6
		if friction:
			movement.x = lerp(movement.x, 0, 0.06)
	else:
		air_timer -= 1
		jump_remember -= 1
		if friction:
			movement.x = lerp(movement.x, 0, 0.07)
	
	if glob.health <= 0 and not dead:
		glob.health = 0
		dead = true
		glob.emit_signal("transition")
		yield(get_tree().create_timer(1), "timeout")
		glob.health = glob.maxHealth
		get_tree().change_scene_to(doorsroom)
	
	animtree.set('parameters/FloorState/current', int(air_timer < 0))
	movement = move_and_slide(movement, Vector2.UP)

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact") and not glob.talking:
		get_viewport().set_input_as_handled()
		glob.emit_signal("interaction")

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

func take_damage(screenshake: int, damage: int):
	intangibility()
	get_node("Camera2D").screenshake(screenshake)
	SoundManager.play_sound(load("res://Data/Sounds/SFX/SFXDamage.wav"))
	
	glob.health -= damage
	glob.emit_signal("hurted")
