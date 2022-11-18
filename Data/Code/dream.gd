extends Area2D

signal captured

func _ready():
	$Anim.play("floating")


func _on_Dream_body_entered(body):
	SoundManager.play_sound(load("res://Data/Sounds/SFX/SFXCheckpoint.wav"))
	emit_signal("captured")
	queue_free()
