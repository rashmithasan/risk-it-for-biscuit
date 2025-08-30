extends Control

@onready var button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.play_menu_music()
	button.connect("pressed", Callable(self, "_on_proceed_pressed"))

func _on_proceed_pressed() -> void:
	$ui_click.play()
	await get_tree().create_timer(0.125).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

#UI_INTERACTION SOUNDS
func _on_button_mouse_entered():
	$ui_interact.play()
