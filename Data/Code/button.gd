extends TextureButton

export(String) var nextScene = 'menuprincipal'

func _on_Button_pressed():
	get_tree().change_scene("res://Data/Scenes/" + nextScene + ".tscn")
