extends Control

@onready var button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("pressed", Callable(self, "_on_proceed_pressed"))

func _on_proceed_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
