extends Control

func _ready():
	$ColorRect/Label.text = str(glob.storage['dreams'])
