extends Node

func play_sound(stream: AudioStream):
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)


	player.finished.connect(player.queue_free)
