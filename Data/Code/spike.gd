extends Node2D



func _on_Area2D_body_entered(body: Player):
	if not body.intangible:
		body.intangibility()
		body.get_node("Camera2D").screenshake(3)
		glob.health -= 15
		glob.emit_signal("hurted")
