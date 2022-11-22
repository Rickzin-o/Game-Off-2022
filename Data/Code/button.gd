extends TextureButton

export(String) var nextScene = 'menuprincipal'

func _on_Button_pressed():
	SoundManager.play_ui_sound(load("res://Data/Sounds/SFX/SFXBlip.wav"))
	get_tree().change_scene("res://Data/Scenes/" + nextScene + ".tscn")
