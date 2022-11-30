extends CPUParticles2D

func _ready():
	set_emitting(true)
	$Timer.wait_time = lifetime
	$Timer.start()

func _on_Timer_timeout():
	queue_free()
