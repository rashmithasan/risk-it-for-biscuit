extends Control

@onready var start = $VBoxContainer/Start
@onready var credits = $VBoxContainer/Credits
@onready var exit = $VBoxContainer/Exit

# Called when the node enters the scene tree for the first time.
func _ready()-> void:
	start.connect("pressed", Callable(self, "_on_start_pressed") )
	credits.connect("pressed", Callable(self, "_on_credits_pressed") )
	exit.connect("pressed", Callable(self, "_on_exit_pressed") )

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Items/Menu and UI/op.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Items/Menu and UI/credits.tscn")
	
func _on_exit_pressed() -> void:
	get_tree().quit()
