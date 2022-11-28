extends Control

var achievements = {"Collector": 'Collect all dreams', "Pacifist": "Complete a level without killing a monster",
"Merchant": "Buy everything from the shop", "Power of Friendship": "Friends"}

onready var labelname = $ColorRect/Name
onready var description = $ColorRect/Description
onready var animplayer = $AnimationPlayer

func _ready():
	glob.connect("goal_reached", self, "appear_achievement")


func set_achievement(achievement: String):
	labelname.text = achievement
	description.text = achievements[achievement]

func appear_achievement(achievement: String):
	set_achievement(achievement)
	animplayer.play("achievement")
