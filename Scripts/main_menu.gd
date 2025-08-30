extends Control

@onready var start = $VBoxContainer/Start
@onready var credits = $VBoxContainer/Credits
@onready var exit = $VBoxContainer/Exit

# Called when the node enters the scene tree for the first time.
func _ready()-> void:
	
	MusicManager.play_menu_music()
	
	start.connect("pressed", Callable(self, "_on_start_pressed") )
	credits.connect("pressed", Callable(self, "_on_credits_pressed") )
	exit.connect("pressed", Callable(self, "_on_exit_pressed") )

func _on_start_pressed() -> void:
	$ui_click.play()
	await get_tree().create_timer(0.125).timeout
	get_tree().change_scene_to_file("res://Scenes/Items/Menu and UI/op.tscn")

func _on_credits_pressed() -> void:
	$ui_click.play()
	await get_tree().create_timer(0.125).timeout
	get_tree().change_scene_to_file("res://Scenes/Items/Menu and UI/credits.tscn")
	
func _on_exit_pressed() -> void:
	$ui_click.play()
	await get_tree().create_timer(0.125).timeout
	get_tree().quit()

#UI_INTERACTION SOUNDS
func _on_start_mouse_entered():
	$ui_interact.play()

func _on_credits_mouse_entered():
	$ui_interact.play()

func _on_exit_mouse_entered():
	$ui_interact.play()
