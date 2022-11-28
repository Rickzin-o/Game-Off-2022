extends KinematicBody2D

const VELOCITY = 100
const DAMAGE = 20

export(int, -1, 1, 2) var direction = 1
var health = 30
var recoil = Vector2.ZERO
var movement = Vector2()

onready var raycast = $RayCast2D

func _ready():
	raycast.position.x = $CollisionShape2D.shape.get_extents().x * direction
	if direction == -1: $Sprite.set_flip_h(true)

func _physics_process(delta):
	movement.y = min(movement.y + 30, 300)
	
	if is_on_wall() or !$RayCast2D.is_colliding() and is_on_floor():
		direction *= -1
		raycast.position.x = $CollisionShape2D.shape.get_extents().x * direction
		$Sprite.flip_h = not $Sprite.flip_h
	
	movement.x = VELOCITY * direction
	
	movement = move_and_slide(movement, Vector2.UP)
