extends ColorRect

export(String) var nome = ''

func _ready():
	if not nome in glob.achievements:
		self.modulate = Color8(150, 150, 150, 200)
