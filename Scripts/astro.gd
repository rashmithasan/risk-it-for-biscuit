extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var gravity: float = 980.0
@export var walk_speed: float = 100.0
@export var max_jump_force: float = 600.0
@export var min_jump_force: float = 200.0
@export var jump_charge_rate: float = 100.0 #How fast the jump power increases per second
@export var max_horizontal_speed: float = 200.0  #Sideways jump strength at full charge

var jump_force: float = 0.0 #How far the player can jump
var is_charging_jump: bool = false

func _physics_process(delta: float) -> void:
	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	#Movement Logic
	
	#Walking (While space not pressed)
	if is_on_floor() and not is_charging_jump:
		var input_dir = Input.get_axis("ui_left", "ui_right")
		velocity.x = input_dir * walk_speed

	#Jump charge
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		is_charging_jump = true
		jump_force = min_jump_force
		velocity.x = 0  # stop walking while charging

	#Hold space to jump
	if is_charging_jump:
		jump_force = min(jump_force + jump_charge_rate * delta, max_jump_force)
		velocity.x = 0  # prevent sliding while charging

	#Jump Release
	if Input.is_action_just_released("ui_accept") and is_charging_jump:
		is_charging_jump = false
		#Vertical jump force
		velocity.y = -jump_force

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

	#Apply movement
	move_and_slide()
