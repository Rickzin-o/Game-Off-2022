extends Control

onready var sfxslider = $SFXVolume

func _ready():
	sfxslider.value = glob.configs['sfx']


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Data/Scenes/menuprincipal.tscn")


func _on_SFXVolume_value_changed(value):
	$SFXVolume/Label.text = str(value)
	SoundManager.set_sound_volume(value/10)
	glob.configs['sfx'] = value
