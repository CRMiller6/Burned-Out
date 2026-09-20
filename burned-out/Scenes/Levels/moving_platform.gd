extends AnimatableBody3D

@export var location_a := Vector3()
@export var location_b := Vector3()
@export var location_c := Vector3()
@export var location_d := Vector3()
@export var location_e := Vector3()
@export var location_f := Vector3()
@export var location_g := Vector3()
@export var location_h := Vector3()
@export var time : float
@export var pause : float
@export var is_eight : bool

func _ready() -> void:
	if is_eight == false:
		move_two()
	elif is_eight == true:
		move_eight()

func move_two():
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", location_b, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	move_tween.tween_property(self, "position", location_a, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	await get_tree().create_timer(2 * time + 2 * pause).timeout
	move_two()
	
func move_eight():
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", location_b, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	move_tween.tween_property(self, "position", location_c, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	move_tween.tween_property(self, "position", location_d, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	move_tween.tween_property(self, "position", location_e, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	move_tween.tween_property(self, "position", location_f, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	move_tween.tween_property(self, "position", location_g, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	move_tween.tween_property(self, "position", location_h, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	move_tween.tween_property(self, "position", location_a, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	await get_tree().create_timer(8 * time + 8 * pause).timeout
	move_two()
	
