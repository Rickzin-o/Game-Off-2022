extends Node2D

var dash_ghost = preload("res://Data/Scenes/Effects and Stuff/dashghost.tscn")
var sprite: Sprite
var colors = [Color(1, 0, 0, 0.8), Color(0, 1, 0, 0.8), Color(0, 0, 1, 0.8), Color(1, 1, 0, 0.8), Color(1, 0, 1, 0.8), Color(0, 1, 1, 0.8)]
var dash_color = colors[randi() % 6]

onready var duration_timer = $DurationTimer
onready var use_timer = $DashTimer
onready var ghost_timer = $GhostTimer

func start_dash(duration: float, sprite):
	self.sprite = sprite
	dash_color = colors[randi() % 6]
	
	duration_timer.wait_time = duration
	duration_timer.start()
	use_timer.start()
	ghost_timer.start()
	
	instance_dash_ghost(dash_color)

func is_dashing():
	return !duration_timer.is_stopped()

func can_dash():
	return use_timer.is_stopped()

func instance_dash_ghost(color):
	var ghost: Sprite = dash_ghost.instance()
	
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h
	ghost.scale = sprite.scale
	ghost.get_material().set_shader_param("color", color)
	
	get_tree().current_scene.add_child(ghost)


func _on_GhostTimer_timeout():
	instance_dash_ghost(dash_color)

func _on_DurationTimer_timeout():
	ghost_timer.stop()
