extends Node2D



func _on_Area2D_body_entered(body: Player):
	if not body.intangible:
		body.take_damage(4, 20)
