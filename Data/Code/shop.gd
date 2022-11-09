extends Control

var index: Vector2 = Vector2()

onready var rect := $ColorRect
onready var reference := $ReferenceRect
onready var num_items = rect.get_child_count()
onready var lines = ceil(float(num_items)/3)


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_right"):
		index.x = int(index.x+1) % 3
		if not index_exist(index):
			index.x = 0
	if Input.is_action_just_pressed("ui_left"):
		index.x = int(index.x-1) % 3
		if index.x <= -1:
			index.x = 2
		while not index_exist(index):
			index.x -= 1
	if Input.is_action_just_pressed("ui_down"):
		index.y = fmod(index.y+1, lines)
		if not index_exist(index):
			index.y = 0
	if Input.is_action_just_pressed("ui_up"):
		index.y = fmod(index.y-1, lines)
		if index.y <= -1: 
			index.y = lines-1
		if not index_exist(index):
			index.y -= 1
	reference_positionx((index.x+1) * 96)
	reference_positiony(index.y * 128 + 96)

func reference_positionx(positionx):
	reference.rect_position.x = positionx

func reference_positiony(positiony):
	reference.rect_position.y = positiony

func index_exist(index: Vector2):
	var verify = index.x + (index.y * 3)
	if verify >= num_items:
		return false
	else:
		return true
