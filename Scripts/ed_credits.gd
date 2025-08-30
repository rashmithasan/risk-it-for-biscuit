extends Control

@onready var button = $Button

func _ready():
	button.connect("pressed", Callable(self, "_on_menu_pressed"))

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Items/Menu and UI/main_menu.tscn")
