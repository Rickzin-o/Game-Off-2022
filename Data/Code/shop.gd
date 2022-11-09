extends Control

var index: int = 0

onready var rect := $ColorRect
onready var detail := $ScrollContainer/Control/Select
onready var num_items = rect.get_child_count()


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_left"):
		index = min(index + 1, num_items)
		if index >= num_items: detail.rect_position += 64
		else: detail.rect_position.y += 112
