extends Node2D

export(int) var speed = 4
export(String, "-1", "1") var direction = "1"

func _process(delta):
	self.rotation_degrees += speed * int(direction) * (delta*60)


func _on_Area2D_body_entered(body):
	if body is Player:
		if not body.intangible:
			body.take_damage(3, 15)
