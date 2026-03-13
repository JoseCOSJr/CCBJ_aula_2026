extends HSlider

@export var bus_name: String = "Musica"
var busSoundId: int
@export var soundPlayerTest: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	busSoundId = AudioServer.get_bus_index(bus_name)
	value = AudioServer.get_bus_volume_linear(busSoundId)*100

func _value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_linear(busSoundId, new_value/100)
	
	if soundPlayerTest:
		soundPlayerTest.stop()
		soundPlayerTest.play()
