extends Control

@export var time = 30
@export var running = true
func _ready() -> void:
	$Timer.wait_time = time
	$Timer.start()

func _process(delta: float) -> void:
	var text = var_to_str(floori($Timer.time_left / 60)) + ":"
	text += var_to_str(int($Timer.time_left) % 60) if len(var_to_str(int($Timer.time_left) % 60)) == 2 else "0" + var_to_str(int($Timer.time_left) % 60)
	var og = var_to_str(floori(time / 60)) + ":"
	og += var_to_str(int(time) % 60) if len(var_to_str(int(time) % 60)) == 2 else "0" + var_to_str(int(time) % 60)
	$ColorRect.size.y = 112 * ($Timer.time_left / $Timer.wait_time)
	$time_left.text = text
	$original_time.text = og
	if running:
		$original_time.visible = true
	else:
		$original_time.visible = false
	
func start():
	if $Timer.is_stopped():
		$Timer.start()
	$Timer.paused = false
	running = true

func reset():
	$Timer.wait_time = time
	$Timer.stop()
	running = false

func pause():
	$Timer.paused = true
	running = false
