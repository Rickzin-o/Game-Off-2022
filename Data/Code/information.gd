extends Control

onready var dream_count = $Dreams
onready var money_count = $Money
onready var lifebar = $Lifebar
onready var tween = $Lifebar/Tween

func _ready():
	dream_count.text = 'Dreams: 0/' + str(glob.totalDreams)
	glob.connect("hurted", self, "update_lifebar")

func _process(delta):
	if glob.totalDreams <= 0:
		dream_count.visible = false
	else:
		dream_count.text = 'Dreams: ' + str(glob.dreams) + '/' + str(glob.totalDreams)
	lifebar.get_node("ColorRect/ReferenceRect/Label").text = str(glob.health) + '/' + str(glob.maxHealth)
	money_count.text = '$%d' % [glob.storage['money']]

func update_lifebar():
	var rect1 = lifebar.get_node("ColorRect")
	var rect2 = lifebar.get_node("ColorRect/ColorRect")
	var updatesize = (160 / float(glob.maxHealth)) * glob.health
	tween.interpolate_property(rect1, "rect_size", rect1.rect_size, Vector2(updatesize, 24), 0.5, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	tween.interpolate_property(rect2, "rect_size", rect2.rect_size, Vector2(updatesize, 24), 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween.start()
