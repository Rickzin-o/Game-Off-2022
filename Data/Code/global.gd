extends Node

signal hurted
signal transition
signal end_level
signal interaction

var storage = {'dreams': 0, 'money': 1000, 'levels': []}
var playersave = {'save_pos': false, 'position': Vector2()}
var talking := false

var dreams := 0
var totalDreams := 0
var room = ''

var health := 100
var maxHealth := 100
var damage := 10

func finish_dialogue():
	talking = false
