extends State

@export 
var fall_state: State
@export
var idle_state: State
@export
var move_state: State
@export
var double_jump_state: State
@export
var jump_force: float = 300.0

func enter() -> void:
	super()
	parent.velocity.y = -jump_force
	
func process_input(event: InputEvent) -> State:
	if get_jump() && !parent.is_on_floor() && get_double_jump():
		return double_jump_state
	return null
func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		return fall_state

	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	if movement != 0:
		parent.animations.flip_h = movement<0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null
