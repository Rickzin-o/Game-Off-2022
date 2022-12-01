extends Node2D

export(float, 0, 2) var speed = 1

func _ready():
	$AnimationPlayer.playback_speed = speed
	$AnimationPlayer.play("spike")
