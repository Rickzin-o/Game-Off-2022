extends Node2D

export(Resource) var resource
export(String) var dialogue = ''

var playerinside = false
var player = null
var talking = false

func _ready():
	glob.connect("interaction", self, "interact")
	if not DialogueManager.is_connected("dialogue_finished", glob, "finish_dialogue"):
		DialogueManager.connect("dialogue_finished", glob, "finish_dialogue")

func _process(delta):
	# Changes the direction NPC is facing
	if player != null and player is Player:
		var playerdirection = sign(player.position.x - global_position.x)
		playerdirection = true if playerdirection == -1 else false
		$Sprite.flip_h = playerdirection

func interact():
	if not playerinside: return
	
	glob.talking = true
	DialogueManager.show_example_dialogue_balloon(dialogue, resource)


func _on_Area2D_body_entered(body):
	if body is Player:
		player = body
	
	playerinside = true


func _on_Area2D_body_exited(body):
	$Sprite.flip_h = false
	player = null
	playerinside = false
