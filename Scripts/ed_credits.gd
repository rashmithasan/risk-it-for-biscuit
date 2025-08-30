extends Control

@onready var button = $Button

func _ready():
	MusicManager.play_menu_music()
	button.connect("pressed", Callable(self, "_on_menu_pressed"))

func _on_menu_pressed() -> void:
	$ui_click.play()
	await get_tree().create_timer(0.125).timeout
	get_tree().change_scene_to_file("res://Scenes/Items/Menu and UI/main_menu.tscn")

#UI_INTERACTION SOUNDS
func _on_button_mouse_entered():
	$ui_interact.play()
