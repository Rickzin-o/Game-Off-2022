extends ColorRect

export(String) var nome = ''
export(bool) var hidden = false
export(Texture) var icon

func _ready():
	if not nome in glob.achievements:
		self.modulate = Color8(150, 150, 150, 200)
		$TextureRect.modulate = Color8(100, 100, 100, 200)
	if nome in glob.achievements and hidden:
		$Label.text = nome
		$TextureRect.texture = icon
