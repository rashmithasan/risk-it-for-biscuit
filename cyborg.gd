extends CharacterBody2D

@export var gravity: float = 1200.0
@export var max_jump_force: float = 1500.0
@export var min_jump_force: float = 400.0
@export var charge_rate: float = 800.0

var charging: bool = false
var jump_force: float = 0.0

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Charging jump
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		charging = true
		jump_force = clamp(jump_force + charge_rate * delta, min_jump_force, max_jump_force)
	
	# Release jump
	if Input.is_action_just_released("ui_accept") and charging:
		charging = false
		var dir = Vector2(Input.get_axis("ui_left", "ui_right"), -1).normalized()
		if dir == Vector2.ZERO:
			dir = Vector2(0, -1)  # default straight up
		velocity = dir * jump_force
		jump_force = 0.0

	# Apply movement
	move_and_slide()
