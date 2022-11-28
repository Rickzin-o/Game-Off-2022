extends TextureButton

export(String) var nextScene = 'menuprincipal'
var hover = false

func _process(delta):
	if self.is_hovered() and not hover:
		hover = true
		var sound = SoundManager.play_ui_sound(load("res://Data/Sounds/SFX/SFXButtonHover.wav"))
		sound.pitch_scale = 1.3
		sound.set_volume_db(-5)
	if not self.is_hovered():
		hover = false

func _on_Button_pressed():
	get_child(0).rect_position.y += 2
	SoundManager.play_ui_sound(load("res://Data/Sounds/SFX/SFXBlip.wav"))
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://Data/Scenes/" + nextScene + ".tscn")
