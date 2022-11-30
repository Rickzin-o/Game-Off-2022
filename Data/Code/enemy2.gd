extends KinematicBody2D

const VELOCITY = 100
const RAGE_VELOCITY = 160
const DAMAGE = 20

export(int, -1, 1, 2) var direction = 1
var health = 30
var enraged = false
var swap_direction = false
var recoil = Vector2.ZERO
var movement = Vector2()

onready var raycast = $RayCast2D
onready var checkmap = $SeePlayer/RayCast2D
onready var anim = $Animation
onready var money = load("res://Data/Scenes/coin.tscn")
onready var particles = load("res://Data/Scenes/Effects and Stuff/hitparticles.tscn")

func _ready():
	raycast.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$SeePlayer.scale.x *= direction
	if direction == -1: $Sprite.set_flip_h(true)

func _physics_process(delta):
	checkmap.enabled = !enraged
	movement.y = min(movement.y + 30, 300)
	
	if is_on_wall() or !$RayCast2D.is_colliding() and is_on_floor():
		change_direction()
	
	if enraged:
		$Sprite.animation = 'rage'
		movement.x = RAGE_VELOCITY * direction
	else:
		$Sprite.animation = 'default'
		movement.x = VELOCITY * direction
	
	movement.x *= (delta*60)
	recoil = recoil.move_toward(Vector2.ZERO, delta * 100)
	
	recoil = move_and_slide(recoil, Vector2.UP)
	movement = move_and_slide(movement, Vector2.UP)

func change_direction():
	direction *= -1
	$SeePlayer.scale.x *= -1
	raycast.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$Sprite.flip_h = not $Sprite.flip_h

func set_movement_multiplier(multiplier: float):
	direction *= multiplier

func set_particles(direc):
	var hitparticles: CPUParticles2D = particles.instance()
	hitparticles.direction.x = direc
	add_child(hitparticles)

func die():
	direction = 0
	glob.kills += 1
	if not glob.room in glob.storage['levels']:
		for i in range(2):
			var jewel = money.instance()
			jewel.position = global_position
			get_tree().current_scene.add_child(jewel)
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
		set_particles(collision_point)
		ball.disappear()
	SoundManager.play_sound(load("res://Data/Sounds/SFX/SFXHit.wav"))
	health -= glob.damage
	anim.play("hit")
	if health <= 0:
		$Hurtbox.set_collision_mask_bit(5, false)
		die()


func _on_Front_View_body_entered(body):
	if not checkmap.is_colliding():
		enraged = true

func _on_Front_View_body_exited(body):
	enraged = false

func _on_Back_View_body_entered(body):
	if not swap_direction:
		$SeePlayer/AnimationPlayer.play("timer")
		swap_direction = true

func _on_Timer_timeout():
	swap_direction = false
