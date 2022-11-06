extends Node2D

onready var doorsroom = load("res://Data/Scenes/Game/doorsroom.tscn")


func _on_Area2D_body_entered(body):
	glob.emit_signal("transition")
	glob.storage['dreams'] += glob.dreams
	
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene_to(doorsroom)
