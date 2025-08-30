extends Area2D

func _ready() -> void:
	#Connect signal
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Astro"): #Only affects astro
		body.respawn() #Call respawn function from player
		$hurt.play()
		
