extends Node2D

var playerinside := false
var empty := false

func _input(event):
	if Input.is_action_just_pressed("interact") and playerinside and not empty:
		empty = true
		glob.storage['money'] += 50


func _on_Area2D_body_entered(body):
	playerinside = true

func _on_Area2D_body_exited(body):
	playerinside = false
