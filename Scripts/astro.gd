extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var gravity: float = 980.0
@export var walk_speed: float = 100.0
@export var max_jump_force: float = 500.0
@export var min_jump_force: float = 200.0
@export var jump_charge_rate: float = 100.0 #How fast the jump power increases per second
@export var max_horizontal_speed: float = 200.0  #Sideways jump strength at full charge

var jump_force: float = 0.0 #How far the player can jump
var is_charging_jump: bool = false

#Item collection
var items_collected: int = 0 #No of items collected
const TOTAL_ITEMS: int = 4 #Max item number

#Biscuit logic
var has_dog: bool = false #Player does not have the dog

#Checkpoints
var checkpoint_position: Vector2 #Checkpoint
var active_checkpoint: Node = null #currently active checkpoint node

func _ready() -> void:
	
	#plays backgroud sounds
	MusicManager.stop_music()
	$bg_noise1.play()
	
	#resets the mute state
	var bus := AudioServer.get_bus_index("Game")
	AudioServer.set_bus_mute(bus, false)  # reset to unmuted
	
	checkpoint_position = global_position
	#Set starting position as checkpoint

func _physics_process(delta: float) -> void:
	
	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	#Movement Logic
	
	#Walking (While space not pressed)
	if is_on_floor() and not is_charging_jump:
		var input_dir = Input.get_axis("ui_left", "ui_right")
		velocity.x = input_dir * walk_speed
		
		#Walking Audio
		if Input.is_action_just_pressed("ui_left"):
			$walk.play()
			
		if Input.is_action_just_pressed("ui_right"):
			$walk.play()
		
		if Input.is_action_just_released("ui_left"):
			$walk.stop()
		
		if Input.is_action_just_released("ui_right"):
			$walk.stop()

	#Jump charge
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		is_charging_jump = true
		jump_force = min_jump_force
		velocity.x = 0  # stop walking while charging
		$walk.stop() #Stops walking sound while charging

	#Hold space to jump
	if is_charging_jump:
		jump_force = min(jump_force + jump_charge_rate * delta, max_jump_force)
		velocity.x = 0  # prevent sliding while charging

	#Jump Release
	if Input.is_action_just_released("ui_accept") and is_charging_jump:
		is_charging_jump = false
		#Vertical jump force
		velocity.y = -jump_force
		$jump.play()

		#Decide jump direction at release
		var dir := 0
		if Input.is_action_pressed("ui_left"):

			dir = -1
		elif Input.is_action_pressed("ui_right"):
			dir = 1

		#Horizontal jump scaling with force
		var horizontal_speed = (jump_force / max_jump_force) * max_horizontal_speed
		velocity.x = dir * horizontal_speed

		jump_force = 0
		
	#Animation Set up
	
	#Flipping left and right
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = false
	
	#Animations
	if is_charging_jump:
		if has_dog:
			animated_sprite_2d.play("charge_w_b")
		else:
			animated_sprite_2d.play("charge")
	elif not is_on_floor():
		if has_dog:
			animated_sprite_2d.play("jump_w_b")
		else:
			animated_sprite_2d.play("jump")
	elif abs(velocity.x) > 0:
		if has_dog:
			animated_sprite_2d.play("move_w_b")
		else:
			animated_sprite_2d.play("move")
	else:
		if has_dog:
			animated_sprite_2d.play("idle_w_b")
		else:
			animated_sprite_2d.play("idle")

	#Apply movement
	move_and_slide()

#Respawn
func respawn() -> void:
	global_position = checkpoint_position
	velocity = Vector2.ZERO #Stop moving
	print ("Respawned")

#Setting up checkpoints
func set_checkpoint(pos: Vector2, checkpoint_node: Node ) -> void:
	checkpoint_position = pos
	print ("checkpoint updated ", pos)
	
	#Reset prev checkpoint
	if active_checkpoint and active_checkpoint != checkpoint_node:
		active_checkpoint.checkpoint_animated_sprite_2D.play("idle")
	#Set new active checkpoint
	active_checkpoint = checkpoint_node
	active_checkpoint.checkpoint_animated_sprite_2D.play("active")

#Item collection
func add_item() -> void:
	items_collected += 1
	print ("Collected: ", items_collected)
