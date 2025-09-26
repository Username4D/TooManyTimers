extends Control

@export var time = 30
@export var running = true
var minute_pressed = false
var seconds_pressed = false
func _ready() -> void:
	$Timer.wait_time = time
	$Timer.start()

func _process(delta: float) -> void:
	var text = var_to_str(floori($Timer.time_left / 60)) + ":"
	text += var_to_str(int($Timer.time_left) % 60) if len(var_to_str(int($Timer.time_left) % 60)) == 2 else "0" + var_to_str(int($Timer.time_left) % 60)
	var og = var_to_str(floori(time / 60)) + ":"
	og += var_to_str(int(time) % 60) if len(var_to_str(int(time) % 60)) == 2 else "0" + var_to_str(int(time) % 60)
	$ColorRect.size.y = 112 * ($Timer.time_left / $Timer.wait_time)

	$original_time.text = og
	if running:
		$original_time.visible = true
	else:
		$original_time.visible = false
	
	if not $Timer.is_stopped():
		$time_left.text = text
	else:
		$time_left.text = og
func start():
	if $jingle.playing:
		$jingle.stop()
	else:
		$Timer.wait_time = time
		if $Timer.is_stopped():
			$Timer.start()
		$Timer.paused = false
		running = true

func reset():
	if $jingle.playing:
		$jingle.stop()
	else:
		$Timer.wait_time = time
		$Timer.stop()
		running = false

func pause():
	if $jingle.playing:
		$jingle.stop()
	else:
		$Timer.paused = true
		running = false

func _on_scrollfield_m_mouse_entered() -> void:
	minute_pressed = true
func _on_scrollfield_m_mouse_exited() -> void:
	minute_pressed = false
func _on_scrollfield_s_mouse_entered() -> void:
	seconds_pressed = true
func _on_scrollfield_s_mouse_exited() -> void:
	seconds_pressed = false
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var ctime = 0
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if minute_pressed:
					ctime += 60
				if seconds_pressed:
					ctime += 1
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if minute_pressed:
					ctime -= 60
				if seconds_pressed:
					ctime -= 1
		if $Timer.is_stopped():
			time += ctime



func _on_timer_timeout() -> void:
	$jingle.play()
