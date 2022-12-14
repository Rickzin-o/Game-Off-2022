extends Node2D

var playerinside = false


func _input(event):
	if Input.is_action_just_pressed("interact"):
		if playerinside:
			$AnimationPlayer.play("explode")

func play_sound():
	var sound = SoundManager.play_sound(load("res://Data/Sounds/SFX/SFXExplosion.wav"))
	sound.pitch_scale = 1.1

func _on_Area2D_body_entered(body):
	playerinside = true


func _on_Area2D_body_exited(body):
	playerinside = false


func _on_Explosion_Hitbox_body_entered(body):
	if body is Player:
		if not body.intangible:
			body.take_damage(6, 30)
