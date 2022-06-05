tool
extends MMNode

const Commons = preload("res://addons/mat_maker_gd/nodes/common/m_m_algos.gd")

export(Resource) var output : Resource
export(Vector3) var size : Vector3 = Vector3(0.3, 0.25, 0.25)
export(float) var radius : float = 0.01

func _init_properties():
	if !output:
		output = MMNodeUniversalProperty.new()
		output.default_type = MMNodeUniversalProperty.MMNodeUniversalPropertyDefaultType.DEFAULT_TYPE_VECTOR2
		
	output.output_slot_type = MMNodeUniversalProperty.SlotTypes.SLOT_TYPE_FLOAT
	output.slot_name = ">>>   Output    >>>"
	output.get_value_from_owner = true

	register_output_property(output)

func _register_methods(mm_graph_node) -> void:
	mm_graph_node.add_slot_label_universal(output)
	
	mm_graph_node.add_slot_vector3("get_size", "set_size", "Size", 0.01)
	mm_graph_node.add_slot_float("get_radius", "set_radius", "Radius", 0.01)

func get_property_value_sdf3d(uv3 : Vector3) -> Vector2:
	return Commons.sdf3d_box(uv3, size.x, size.y, size.z, radius)

#size
func get_size() -> Vector3:
	return size

func set_size(val : Vector3) -> void:
	size = val

	emit_changed()
	output.emit_changed()

#radius
func get_radius() -> float:
	return radius

func set_radius(val : float) -> void:
	radius = val

	emit_changed()
	output.emit_changed()
