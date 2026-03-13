extends Control
class_name  Fade

const colorFadeIn: Color = Color(Color.BLACK, 0)

var speedFade: float = 1
var progressFade: float
var colorStart: Color
var colorTarget: Color

static var fadeInScene: Fade = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colorTarget = modulate
	fadeInScene = self
	#StartFade(colorFadeOut, 1)
	
	#PaiDeTodos.gravidade = 5
	#fade = get_tree().get_first_node_in_group("Fade")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if modulate == colorTarget:
		if modulate.a <= 0 and visible:
			hide()
		
		return
	
	if progressFade < 1:
		progressFade += speedFade*delta
	else :
		return
	
	modulate = colorStart.lerp(colorTarget, progressFade)

func StartFade(colorGo: Color, speed: float)->void:
	colorStart = modulate
	progressFade = 0
	colorTarget = colorGo
	
	speedFade = speed
	show()
	
func FadeIn(speed: float)->void:
	StartFade(colorFadeIn, speed)
