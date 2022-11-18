extends CanvasLayer

onready var transrect = $Transition
onready var transanim = $Transition/AnimationPlayer

func _ready():
	transrect.set_visible(true)
	glob.talking = true
	transanim.play("disappear")
	glob.connect("transition", self, "end_screen")

func end_screen():
	glob.talking = true
	transanim.play("appear")

func set_end():
	glob.talking = false
