extends Control

onready var dreamCount = $Label

func _ready():
	dreamCount.text = 'Dreams: 0/' + str(glob.totalDreams)

func _process(delta):
	dreamCount.text = 'Dreams: ' + str(glob.dreams) + '/' + str(glob.totalDreams)
