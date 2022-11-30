extends Node2D

export(int, 0, 10) var speed = 4
export(int, -1, 1, 2) var direction = 1

func _process(delta):
	self.rotation_degrees += speed * direction * (delta*60)


func _on_Area2D_body_entered(body):
	if body is Player:
		if not body.intangible:
			body.take_damage(4, 20)
