extends Node2D

export(float, 0, 4, 0.1) var speed = 1
export(Vector2) var direction = Vector2(0, 1)
#export(String, "BEGINNING", "END") var start := "BEGINNING"

onready var beg := $Beginning
onready var end := $End

func _ready():
	$Animation.play("effect")

func _process(delta):
	$Platform.position += direction * (speed * delta * 60)

func change_direction():
	direction *= -1


func _on_Beginning_area_entered(area):
	change_direction()

func _on_End_area_entered(area):
	change_direction()
