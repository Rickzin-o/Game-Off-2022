extends Node

signal hurted
signal transition
signal end_level
signal dialogue_end

var storage = {'dreams': 0, 'levels': []}
var playersave = {'save_pos': false, 'position': Vector2()}

var dreams = 0
var totalDreams = 0

var health = 100
var maxHealth = 100
