extends Control

var index: Vector2 = Vector2()

onready var rect := $ColorRect
onready var reference := $ReferenceRect
onready var info_rect := $InfoRect
onready var money := $Label
onready var num_items = rect.get_child_count()
onready var lines = ceil(float(num_items)/3)

func _ready():
	check_items()
	set_visibility(false)
	glob.connect("shop", self, "shop_appear")
	var first_item_info = get_item_info(rect.get_child(0))
	set_item_info(first_item_info)
	money.text = "Money: $%d" % [glob.storage['money']]


func _input(event):
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
	
	var item = rect.get_child(index.x + index.y*3)
	var item_info = get_item_info(item)
	set_item_info(item_info)
	
	if Input.is_action_just_pressed("ui_accept"): #Set item as Sold when ui_accept is pressed
		if item_info['name'] != "Sold" and glob.storage['money'] >= item_info['price']:
			glob.storage['money'] -= item_info['price']
			item_sold(item)
			item_effect(item)
			money.text = "Money: $%d" % [glob.storage['money']]


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel") and visible:
		set_visibility(false, true)


func shop_appear():
	set_visibility(true, true)


func reference_positionx(positionx):
	reference.rect_position.x = positionx


func reference_positiony(positiony):
	reference.rect_position.y = positiony


func index_exist(index: Vector2): # Checks if index exist
	var verify = index.x + (index.y * 3)
	if verify >= num_items:
		return false
	else:
		return true


func check_items():
	for child in rect.get_children():
		if child is ShopItem:
			if child.item_name in glob.items: item_sold(child)


func get_item_info(item: ShopItem):
	return {"name": item.item_name, "price": item.price, "description": item.description}


func set_item_info(info):
	info_rect.get_node("Label").text = "%s - %d$" % [info['name'], info['price']]
	info_rect.get_node("Description").text = ' ' + info['description']


func item_sold(item: ShopItem):
	if not item.item_name in glob.items: glob.items.append(item.item_name)
	item.item_name = 'Sold'
	item.description = ''
	item.price = 0

func item_effect(item: ShopItem): # Set changes when player buy item
	if item.effect['Health'] > 0:
		glob.maxHealth += item.effect['Health']
	if item.effect['Damage'] > 0:
		glob.damage += item.effect['Damage']

func set_visibility(value: bool, set_var: bool = false): # Set Visible and Input Process as Value
	set_process_input(value)
	set_visible(value)
	if set_var: # If set_var is true, variables will also be set as Value
		glob.talking = value
		glob.shopping = value
