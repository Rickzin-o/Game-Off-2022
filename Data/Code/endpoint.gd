extends Node2D

export(String) var room = ''

var playerinside = false

onready var twn = $Tween
onready var doorsroom = load("res://Data/Scenes/Game/doorsroom.tscn")
onready var dialogue = load("res://Data/Others/Dialogues/door.tres")

func _ready():
	glob.connect("interaction", self, "interact")

func interact():
	if not playerinside: return
	
	if glob.dreams >= glob.totalDreams:
		end_level()
	else:
		glob.talking = true
		DialogueManager.connect("dialogue_finished", glob, "finish_dialogue")
		DialogueManager.show_example_dialogue_balloon("not_enough_dreams", dialogue)

func end_level():
	glob.emit_signal("transition")
	glob.emit_signal("end_level")
	glob.storage['dreams'] += glob.dreams
	yield(get_tree().create_timer(1), "timeout")
	glob.playersave['save_pos'] = true
	get_tree().change_scene_to(doorsroom)

func _on_Area2D_body_entered(body):
	playerinside = true
	twn.interpolate_property($Label, "modulate", $Label.modulate, Color8(255, 255, 255, 200), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	twn.start()

func _on_Area2D_body_exited(body):
	playerinside = false
	twn.interpolate_property($Label, "modulate", $Label.modulate, Color8(255, 255, 255, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	twn.start()
