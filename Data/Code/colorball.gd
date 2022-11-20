extends RigidBody2D
class_name ColorfulBall

var direction : int
onready var particles := $CPUParticles2D
onready var hitbox = $Hitbox
onready var sprite = $ColorRect

func _ready():
	modulate = [Color(1, 0.1, 0.1), Color(0.1, 1, 0.1), Color(0.1, 0.1, 1)][randi() % 3]
	apply_impulse(Vector2(), Vector2(400 * direction, 0))

func disappear():
	particles.set_emitting(true)
	sprite.visible = false
	hitbox.set_collision_layer_bit(5, false)
	hitbox.set_collision_mask_bit(1, false)
	yield(get_tree().create_timer(particles.lifetime), "timeout")
	particles.visible = false
	queue_free()


func _on_Hitbox_body_entered(body):
	disappear()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
