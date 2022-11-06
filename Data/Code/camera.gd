extends Camera2D

onready var twn = $Tween
onready var shake_timer = $Timer
onready var default_offset = offset
var shake_amount = 0

func _ready():
	set_process(false)

func _process(delta):
	offset = Vector2(rand_range(-shake_amount, shake_amount), rand_range(-shake_amount, shake_amount))

func screenshake(new_shake, shake_time=0.3, limit=100):
	shake_amount += new_shake
	if shake_amount > limit:
		shake_amount = limit
	
	twn.stop_all()
	shake_timer.start(shake_time)
	set_process(true)


func _on_Timer_timeout():
	shake_amount = 0
	set_process(false)
	
	twn.interpolate_property(self, "offset", offset, default_offset, 0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	twn.start()
