extends Node3D
class_name Vibration

func StartVibration(weak: float, strong: float, duration)->void:
	Input.stop_joy_vibration(0)
	Input.start_joy_vibration(0, weak, strong, duration)
