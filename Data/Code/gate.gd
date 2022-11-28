extends Node2D

export(Vector2) var go_to = Vector2()

onready var initial_pos = position
onready var twn = $Tween

func open():
	twn.interpolate_property(self, "position", position, initial_pos+go_to, 1, Tween.TRANS_QUINT, Tween.EASE_OUT)
	twn.start()

func close():
	twn.interpolate_property(self, "position", position, initial_pos, 1, Tween.TRANS_QUINT, Tween.EASE_OUT)
	twn.start()

func change_state(state: bool):
	if state:
		open()
	else:
		close()

func _on_Lever_pressed(state: bool):
	change_state(state)


func _on_Pressure_Button_activated(state: bool):
	change_state(state)

