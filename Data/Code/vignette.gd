extends ColorRect

onready var twn = $Tween

func _process(delta):
	if glob.health <= (glob.maxHealth/5):
		twn.interpolate_property(self, "modulate:a", 0, 1, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		twn.start()
		set_process(false)
