extends Node2D

signal activated

var pressed = false



func _on_Area2D_area_entered(area):
	pressed = not pressed
	$Sprite.frame = bool(pressed)
	emit_signal("activated", pressed)
	
	var ball = area.get_parent()
	if ball is ColorfulBall:
		modulate = ball.modulate + Color(0.5, 0.5, 0.5)
