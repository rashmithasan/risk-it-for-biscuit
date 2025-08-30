extends CanvasLayer

@onready var pause = $HBoxContainer/Pause
@onready var music = $HBoxContainer/Music
@onready var menu = $HBoxContainer/Menu
@onready var main_music = $"../AudioStreamPlayer2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS  # So this UI processes input even when paused
	
	pause.connect("pressed", Callable(self, "_on_pause_pressed"))
	music.connect("pressed", Callable(self, "_on_music_pressed"))
	menu.connect("pressed", Callable(self, "_on_menu_pressed"))

func _on_pause_pressed() -> void:
	get_tree().paused = !get_tree().paused

func _on_music_pressed() -> void:
	var bus := AudioServer.get_bus_index("Game")
	var current_state := AudioServer.is_bus_mute(bus)
	AudioServer.set_bus_mute(bus, not current_state)
	

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Items/Menu and UI/main_menu.tscn")
