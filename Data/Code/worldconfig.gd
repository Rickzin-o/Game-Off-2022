extends Node2D

func _ready():
	glob.health = glob.maxHealth
	glob.dreams = 0
	glob.totalDreams = $Dreams.get_child_count()


func _on_Dream_captured():
	glob.dreams += 1
