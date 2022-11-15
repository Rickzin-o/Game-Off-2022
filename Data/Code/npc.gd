extends Node2D

export(Resource) var resource
export(String) var dialogue = ''

var playerinside = false
var talking = false

func _ready():
	glob.connect("dialogue_end", self, "set_not_talking")

func _input(event):
	if playerinside and Input.is_action_just_pressed("interact"):
		glob.talking = true
		DialogueManager.show_example_dialogue_balloon(dialogue, resource)

func set_not_talking():
	print('oxi')
	glob.talking = false

func _on_Area2D_body_entered(body):
	playerinside = true


func _on_Area2D_body_exited(body):
	playerinside = false
