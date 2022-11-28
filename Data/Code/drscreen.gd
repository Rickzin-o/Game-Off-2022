extends Control

func _ready():
	SoundManager.play_music_at_volume(load("res://Data/Sounds/Music/room.ogg"), 6)
	$ColorRect/Label.text = str(glob.storage['dreams'])
