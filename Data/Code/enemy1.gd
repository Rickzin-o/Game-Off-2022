extends KinematicBody2D

const VELOCITY = 75
const DAMAGE = 20

export(int, -1, 1) var direction = 1
var health = 20
var recoil = Vector2.ZERO
var movimento = Vector2()

onready var raycast = $RayCast2D
onready var anim = $Animation
onready var money = load("res://Data/Scenes/coin.tscn")


func _ready():
	raycast.position.x = $CollisionShape2D.shape.get_extents().x * direction
	if direction == -1: $Sprite.set_flip_h(true)

func _physics_process(delta):
	movimento.y = min(movimento.y + 30, 300)
	
	if is_on_wall() or !$RayCast2D.is_colliding() and is_on_floor():
		direction *= -1
		$Sprite.flip_h = not $Sprite.flip_h
		raycast.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	movimento.x = VELOCITY * direction
	
	recoil = recoil.move_toward(Vector2.ZERO, delta * 60)
	
	recoil = move_and_slide(recoil, Vector2.UP)
	movimento = move_and_slide(movimento, Vector2.UP)


func die():
	direction = 0
	if not glob.room in glob.storage['levels']:
		for i in range(2):
			var coin = money.instance()
			coin.position = global_position
			get_tree().current_scene.add_child(coin)
	yield(get_tree().create_timer(0.2), "timeout")
	queue_free()


func _on_Hitbox_body_entered(body):
	if body is Player:
		if not body.intangible:
			body.take_damage(4, DAMAGE)

func _on_Hurtbox_area_entered(area):
	var ball = area.get_parent()
	if ball is ColorfulBall:
		var collision_point = sign(global_position.x - ball.global_position.x)
		recoil = Vector2(collision_point * 30, 0)
		ball.disappear()
	health -= glob.damage
	anim.play("hit")
	if health <= 0:
		$Hurtbox.set_collision_mask_bit(5, false)
		die()
