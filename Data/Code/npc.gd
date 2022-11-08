extends Node2D

export(Resource) var resource
export(String) var dialogue = ''

var playerinside = false
var talking = false

func _ready():
	glob.connect("dialogue_end", self, "set_talking", [false])

func _input(event):
	if playerinside and Input.is_action_just_pressed("interact"):
		set_talking(true)
		DialogueManager.show_example_dialogue_balloon(dialogue, resource)

func set_talking(state: bool):
	talking = state

func _on_Area2D_body_entered(body):
	playerinside = true


func _on_Area2D_body_exited(body):
	playerinside = false
