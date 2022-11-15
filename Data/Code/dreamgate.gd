extends Node2D

export(int) var dreams = 0

var can_open = false
var playerinside = false

onready var twn = $Tween

func _ready():
	$Label.text = "%d/%d" % [glob.storage['dreams'], dreams]
	if glob.storage['dreams'] >= dreams:
		$Label.modulate = Color8(70, 230, 70)
		can_open = true

func _input(event):
	if can_open and playerinside and Input.is_action_just_pressed("interact"):
		$Area2D.monitoring = false
		twn.interpolate_property(self, "position", position, position + Vector2(0, -112), 1, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
		twn.start()


func _on_Area2D_body_entered(body):
	playerinside = true

func _on_Area2D_body_exited(body):
	playerinside = false