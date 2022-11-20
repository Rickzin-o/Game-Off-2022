extends Node2D

signal entered

export(PackedScene) var goTo
onready var twn = $Tween
var playerinside = false
var player = null

func _input(event):
	if Input.is_action_just_pressed("interact") and playerinside:
		emit_signal("entered")
		glob.playersave['position'] = global_position + Vector2(-16, -32)
		glob.talking = true
		$Timer.start()
		
		if player is Player:
			player.animtree.set('parameters/Action/current', 2)


func _on_Area2D_body_entered(body):
	self.connect("entered", body, "cam_zoomin")
	playerinside = true
	player = body
	twn.interpolate_property($Label, "modulate", $Label.modulate, Color8(255, 255, 255, 200), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	twn.start()


func _on_Area2D_body_exited(body):
	self.disconnect("entered", body, "cam_zoomin")
	playerinside = false
	player = null
	twn.interpolate_property($Label, "modulate", $Label.modulate, Color8(255, 255, 255, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	twn.start()


func _on_Timer_timeout():
	if goTo != null:
		glob.talking = false
		get_tree().change_scene_to(goTo)
