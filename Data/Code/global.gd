extends Node

signal hurted
signal transition
signal end_level
signal interaction
signal shop

var storage = {'dreams': 0, 'money': 0, 'levels': []}
var playersave = {'save_pos': false, 'position': Vector2()}
var configs = {'sfx': 10, 'music': 10}
var achievements := []
var items := []
var talking := false
var shopping := false

var dreams := 0
var totalDreams := 0
var room = ''
var savemoney = storage['money']

var health := 100
var maxHealth := 100
var damage := 10
var speedboots = 0

func money_reset():
	storage['money'] = savemoney

func finish_dialogue():
	talking = false if not shopping else true

