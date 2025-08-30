extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sound_bark = $bark

var picked_up: bool = false #prevent multiple pickups

# Called when the node enters the scene tree for the first time.
func _ready()-> void:
	
	animated_sprite_2d.play("dog_idle")
	
	#Connect body entered signal
	self.body_entered.connect(_on_body_entered)
	pass # Replace with function body.

func _on_body_entered(body: Node) -> void:
	if picked_up:
		return #ignore if already picked up
	if body.is_in_group("Astro"): #Only player entering will trigger the event
		picked_up = true #Player has picked up the dog
		sound_bark.play() #Bark
		animated_sprite_2d.visible = false #Hide animation 
		body.has_dog = true #Tell player they have the dog
