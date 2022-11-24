extends TextureButton

export(String) var nextScene = 'menuprincipal'

func _on_Button_pressed():
	get_child(0).rect_position.y += 2
	SoundManager.play_ui_sound(load("res://Data/Sounds/SFX/SFXBlip.wav"))
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://Data/Scenes/" + nextScene + ".tscn")
