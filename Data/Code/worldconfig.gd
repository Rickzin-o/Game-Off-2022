extends Node2D

export(String) var room = ''

func _ready():
	glob.connect("end_level", self, "save_things")
	glob.health = glob.maxHealth
	glob.dreams = 0
	if room in glob.storage['levels']:
		self.remove_child($Dreams)
		glob.totalDreams = 0
	else:
		glob.totalDreams = $Dreams.get_child_count()

func save_things():
	glob.storage['levels'].append(room)

func _on_Dream_captured():
	glob.dreams += 1
