extends Area2D

signal captured

func _ready():
	$Anim.play("floating")


func _on_Dream_body_entered(body):
	emit_signal("captured")
	queue_free()
