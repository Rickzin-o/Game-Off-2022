extends Control

var achievements = {"Collector": 'Collect all dreams', "Pacifist": "Complete a level without killing a monster",
"Merchant": "Buy an item from the shop", "Power of Friendship": "Make B1B0T happy"}

onready var labelname = $ColorRect/Name
onready var description = $ColorRect/Description
onready var animplayer = $AnimationPlayer

func _ready():
	glob.connect("goal_reached", self, "appear_achievement")


func set_achievement(achievement: String):
	labelname.text = achievement
	description.text = achievements[achievement]

func appear_achievement(achievement: String):
	if achievement in achievements.keys() and not achievement in glob.achievements:
		set_achievement(achievement)
		glob.achievements.append(achievement)
		animplayer.play("achievement")
