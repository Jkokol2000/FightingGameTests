extends State

@export
var fall_state: State
@export
var jump_state: State
@export
var idle_state: State

func enter() -> void:
	super()
	move_component.air_jump_count = move_component.air_jump_maximum
func process_input(event: InputEvent) -> State:
	if get_jump() and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
		
	var movement = get_movement_input() * move_speed
	if movement != 0:
		parent.animations.flip_h = movement < 0
	else:
		return idle_state
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
