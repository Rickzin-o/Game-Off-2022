extends Node2D

signal entered

export(PackedScene) var goTo
onready var twn = $Tween
var playerinside = false
var player = null

func _input(event):
	if Input.is_action_just_pressed("interact") and playerinside:
		emit_signal("entered")
		$Timer.start()


func _on_Area2D_body_entered(body):
	self.connect("entered", body, "cam_zoomin")
	playerinside = true
	twn.interpolate_property($Label, "modulate", $Label.modulate, Color8(255, 255, 255, 200), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	twn.start()


func _on_Area2D_body_exited(body):
	self.disconnect("entered", body, "cam_zoomin")
	playerinside = false
	twn.interpolate_property($Label, "modulate", $Label.modulate, Color8(255, 255, 255, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	twn.start()


func _on_Timer_timeout():
	if goTo != null:
		get_tree().change_scene_to(goTo)
