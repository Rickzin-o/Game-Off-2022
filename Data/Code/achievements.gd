extends Control

func _ready():
	$Label2.text = '%d/4' % [len(glob.achievements)]

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Data/Scenes/menuprincipal.tscn")
