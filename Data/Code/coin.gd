extends RigidBody2D

var color_list = [Color8(250, 100, 100), Color8(100, 250, 100), Color8(100, 100, 250), Color8(250, 240, 70)]

func _ready():
#	$Polygon2D.color = color_list[randi() % 4]
	$Sprite.frame = randi() % 4
	apply_impulse(Vector2.ZERO, Vector2(rand_range(-60, 60), -100))


func _on_Coin_body_entered(body):
	sleeping = true


func _on_Area2D_body_entered(body):
	SoundManager.play_sound(load("res://Data/Sounds/SFX/Coins/SFXCoin%d.wav" % [randi() % 3 + 1]))
	glob.storage['money'] += 10
	queue_free()
