extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Astro"): #Only responds to player
		if body.items_collected >= body.TOTAL_ITEMS:
			if body.has_dog == true:
				get_tree().change_scene_to_file("res://Scenes/Items/Menu and UI/ed.tscn")
			else:
				get_tree().change_scene_to_file("res://Scenes/Items/Menu and UI/go.tscn")
		else:
			pass
