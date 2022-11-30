extends Node2D

export(int) var dreams = 1
export(String) var special_item = ""
export(Texture) var special_icon

var can_open = false
var playerinside = false

onready var twn = $Tween

func _ready():
	if special_item != "":
		$Label.set_visible(false)
		$Special.texture = special_icon
		if special_item in glob.items:
			can_open = true
	
	$Label.text = "%d/%d" % [glob.storage['dreams'], dreams]
	if glob.storage['dreams'] >= dreams:
		$Label.modulate = Color8(70, 230, 70)
		can_open = true

func _on_Area2D_body_entered(body):
	playerinside = true
	if can_open:
		$Area2D.set_collision_mask_bit(0, false)
		twn.interpolate_property(self, "position", position, position + Vector2(0, -112), 1, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
		twn.start()

func _on_Area2D_body_exited(body):
	playerinside = false
