extends Area2D

@onready var sound = $AudioStreamPlayer2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Astro"): #Only respond to player
		sound.play()
		body.add_item() #Item counted by the player
		queue_free() #Remove item
