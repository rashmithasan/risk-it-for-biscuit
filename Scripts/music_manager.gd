extends Node

@onready var player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready():
	add_child(player)
	player.autoplay = false

func play_menu_music():
	if not player.playing:
		player.stream = preload("res://Assets/Music/opening.ogg")
		player.play()

func stop_music():
	if player.playing:
		player.stop()
