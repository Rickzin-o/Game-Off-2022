extends Node

signal hurted
signal transition
signal end_level
signal interaction

var storage = {'dreams': 0, 'money': 0, 'levels': []}
var talking := false

var dreams := 0
var totalDreams := 0

var health := 100
var maxHealth := 100
