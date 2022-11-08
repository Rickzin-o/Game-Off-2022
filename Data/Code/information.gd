extends Control

onready var dreamCount = $Label
onready var lifebar = $Lifebar
onready var tween = $Lifebar/Tween

func _ready():
	dreamCount.text = 'Dreams: 0/' + str(glob.totalDreams)
	glob.connect("hurted", self, "update_lifebar")

func _process(delta):
	if glob.totalDreams <= 0:
		dreamCount.visible = false
	dreamCount.text = 'Dreams: ' + str(glob.dreams) + '/' + str(glob.totalDreams)
	lifebar.get_node("ColorRect/ReferenceRect/Label").text = str(glob.health) + '/' + str(glob.maxHealth)

func update_lifebar():
	var rect1 = lifebar.get_node("ColorRect")
	var rect2 = lifebar.get_node("ColorRect/ColorRect")
	var updatesize = 1.6 * glob.health
	tween.interpolate_property(rect1, "rect_size", rect1.rect_size, Vector2(updatesize, 24), 0.5, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	tween.interpolate_property(rect2, "rect_size", rect2.rect_size, Vector2(updatesize, 24), 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween.start()
