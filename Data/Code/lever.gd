extends Node2D

signal pressed

var playerinside := false
var active := false

func _input(event):
	if playerinside and Input.is_action_just_pressed("interact"):
		active = not active
		$Polygon2D.scale.x *= -1
		emit_signal("pressed", active)


func _on_Area2D_body_entered(body):
	playerinside = true

func _on_Area2D_body_exited(body):
	playerinside = false
