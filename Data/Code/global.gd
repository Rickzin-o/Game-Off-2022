extends Node

signal hurted
signal transition
signal end_level
signal interaction
signal shop
signal goal_reached

var storage = {'dreams': 0, 'money': 0, 'levels': []}
var playersave = {'save_pos': false, 'position': Vector2()}
var configs := {'sfx': 10, 'music': 10}
var achievements := []
var items := []
var talking := false
var shopping := false

var dreams := 0
var totalDreams := 0
var kills = 0
var room = ''
var savemoney = storage['money']

var health := 100
var maxHealth := 100
var damage := 10
var speedboots = 0

var has_met_bibot = false
var has_met_guard = false

var path = 'user://game.dat'

func _ready():
	AudioServer.add_bus(1)
	AudioServer.set_bus_name(1, "Sound")


func money_reset():
	storage['money'] = savemoney


func finish_dialogue():
	talking = false if not shopping else true


func give_key():
	for i in range(2):
		if "key_fragment" in items:
			items.erase("key_fragment")
	items.append("secretkey")


func count_item(item: String):
	return items.count(item)


func check_level_completed(level: String): # Check if a level is completed
	return level in storage['levels']


func save_game():
	var file = File.new()
	var err = file.open(path, file.WRITE)
	if err == OK:
		file.store_var(storage)
		file.store_var(configs)
		file.store_var(achievements)
		file.store_var(items)
		file.store_var(maxHealth)
		file.store_var(damage)


func load_game():
	var file = File.new()
	var err = file.open(path, file.READ)
	if err == OK:
		storage = file.get_var()
		configs = file.get_var()
		achievements = file.get_var()
		items = file.get_var()
		maxHealth = file.get_var()
		damage = file.get_var()
		SoundManager.set_sound_volume(configs['sfx']/10)


func reset_game():
	storage = {'dreams': 0, 'money': 0, 'levels': []}
	configs = {'sfx': 10, 'music': 10}
	achievements = []
	items = []
	maxHealth = 100
	damage = 10
	save_game()
