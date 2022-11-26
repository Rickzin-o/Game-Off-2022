extends Control

#The game pause when ESC is pressed
func _input(event):
	if Input.is_action_just_pressed("ui_cancel") and not glob.talking:
		var pausestate = not get_tree().is_paused()
		visible = pausestate
		get_tree().set_pause(pausestate)


func _on_Return_pressed():
	if visible:
		visible = false
		get_tree().set_pause(false)

func _on_Restart_pressed():
	if visible:
		glob.money_reset()
		get_tree().set_pause(false)
		get_tree().reload_current_scene()

func _on_Quit_pressed():
	if visible:
		glob.money_reset()
		get_tree().set_pause(false)
		get_tree().change_scene("res://Data/Scenes/menuprincipal.tscn")
