extends Control



func _on_start_pause_pressed() -> void:
	if $timer.running:
		$timer.pause()
	else:
		$timer.start()

func _process(delta: float) -> void:
	if $timer.running:
		$start_pause.text = "Pause"
	else:
		$start_pause.text = "Start"

func _on_reset_pressed() -> void:
	$timer.reset()
