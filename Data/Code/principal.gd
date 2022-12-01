extends Control


func _ready():
	SoundManager.set_default_music_bus("Music")
	SoundManager.play_music(load("res://Data/Sounds/Music/menu.ogg"))
