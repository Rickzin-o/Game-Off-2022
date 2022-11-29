extends Node2D

export(bool) var give_item = false
export(String) var item = ''

var playerinside := false
var empty := false

onready var trash_dialogue = load("res://Data/Others/Dialogues/trash.tres")

func _ready():
	glob.connect("interaction", self, "interact")
	if not DialogueManager.is_connected("dialogue_finished", glob, "finish_dialogue"):
		DialogueManager.connect("dialogue_finished", glob, "finish_dialogue")

func interact():
	if not playerinside: return
	
	glob.talking = true
	if empty or glob.room in glob.storage['levels']:
		DialogueManager.show_example_dialogue_balloon("empty", trash_dialogue)
	else:
		empty = true
		if not give_item:
			glob.storage['money'] += 20
			DialogueManager.show_example_dialogue_balloon("trash_can", trash_dialogue)
		else:
			glob.items.append(item)
			DialogueManager.show_example_dialogue_balloon(item, trash_dialogue)


func _on_Area2D_body_entered(body):
	playerinside = true

func _on_Area2D_body_exited(body):
	playerinside = false
