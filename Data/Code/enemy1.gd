extends KinematicBody2D

const VELOCITY = 150
const DAMAGE = 20

export(int, -1, 1) var direction = 1
var movimento = Vector2()

onready var raycast = $RayCast2D
onready var money = load("res://Data/Scenes/coin.tscn")


func _ready():
	raycast.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _physics_process(delta):
	movimento.y = min(movimento.y + 30, 300)
	
	if is_on_wall() or !$RayCast2D.is_colliding() and is_on_floor():
		direction *= -1
		raycast.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	movimento.x = VELOCITY * direction
	
	movimento = move_and_slide(movimento, Vector2.UP)

func _input(event):
	if Input.is_key_pressed(KEY_B):
		die()

func die():
	direction = 0
	for i in range(2):
		var coin = money.instance()
		coin.position = global_position
		get_tree().current_scene.add_child(coin)
	queue_free()


func _on_Hitbox_body_entered(body):
	if body is Player:
		if not body.intangible:
			body.get_node("Camera2D").screenshake(4)
			body.intangibility()
			glob.health -= DAMAGE
			glob.emit_signal("hurted")
