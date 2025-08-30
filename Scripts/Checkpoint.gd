extends Area2D

@onready var checkpoint_animated_sprite_2D = $AnimatedSprite2D
@onready var collected_sound = $cookie_crunch

#var activated : bool = false #Prevent multiple pickups

func _ready() -> void:
	checkpoint_animated_sprite_2D.play("idle")
	body_entered.connect(_on_body_entered) #Connect signal

func _on_body_entered(body: Node) -> void:
	#if activated:
		#return #Already activated
	
	if body.is_in_group("Astro"): #Only interact with player
		#activated = true
		body.set_checkpoint(global_position, self) #Let player know this is the active checkpoint
		checkpoint_animated_sprite_2D.play("active")
		print(global_position) #output
		collected_sound.play() #Sound
		
	
