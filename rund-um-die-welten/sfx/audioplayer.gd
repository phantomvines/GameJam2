extends Node

# For sound effects
var active_players: Array = []

# For music
var music_player: AudioStreamPlayer = null


func play_sound(stream: AudioStream):
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.process_mode = Node.PROCESS_MODE_ALWAYS  # Plays even if paused
	add_child(player)
	player.play()

	active_players.append(player)

	player.finished.connect(func():
		active_players.erase(player)
		player.queue_free()
	)


func stop_all():
	for player in active_players:
		if player.playing:
			player.stop()
			player.queue_free()
	active_players.clear()


func play_music(path: String):
	var stream = load(path) as AudioStream
	if not stream:
		push_error("Invalid music path: " + path)
		return

	# Stop existing music
	if music_player and music_player.playing:
		music_player.stop()
		music_player.queue_free()
		music_player = null

	# Create new music player
	music_player = AudioStreamPlayer.new()
	music_player.stream = stream
	music_player.bus = "Music"  # Optional: use a dedicated bus
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	music_player.volume_db = 0  # Adjust volume if needed
	add_child(music_player)
	music_player.play()


func stop_music():
	if music_player:
		music_player.stop()
		music_player.queue_free()
		music_player = null
