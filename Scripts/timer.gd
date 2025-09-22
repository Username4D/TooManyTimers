extends Control

@export var time = 30

func _ready() -> void:
	$Timer.wait_time = time
	$Timer.start()

func _process(delta: float) -> void:
	var text = var_to_str(floori($Timer.time_left / 60)) + ":"
	text += var_to_str(int($Timer.time_left) % 60) if len(var_to_str(int($Timer.time_left) % 60)) == 2 else "0" + var_to_str(int($Timer.time_left) % 60)
	$ColorRect.size.y = 112 * ($Timer.time_left / $Timer.wait_time)
	$time_left.text = text
