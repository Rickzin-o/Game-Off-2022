extends Node2D

var playerinside = false
export(int, 0, 20) var value = 1

func _ready():
	glob.connect("interaction", self, "interact")
	if not DialogueManager.is_connected("dialogue_finished", glob, "finish_dialogue"):
		DialogueManager.connect("dialogue_finished", glob, "finish_dialogue")

func interact():
	if not playerinside: return
	
	glob.talking = true
	DialogueManager.show_example_dialogue_balloon("sign%d" % [value], load("res://Data/Others/Dialogues/signs.tres"))


func _on_Area2D_body_entered(body):
	playerinside = true

func _on_Area2D_body_exited(body):
	playerinside = false
