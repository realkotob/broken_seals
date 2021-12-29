tool
extends EditorSpatialGizmo

var MeshOutline = preload("res://addons/mesh_data_resource_editor/utilities/mesh_outline.gd")
var MeshDecompose = preload("res://addons/mesh_data_resource_editor/utilities/mesh_decompose.gd")

enum EditMode {
	NONE, TRANSLATE, SCALE, ROTATE
}

enum AxisConstraint {
	X = 1 << 0, 
	Y = 1 << 1, 
	Z = 1 << 2,
}

enum SelectionMode {
	SELECTION_MODE_VERTEX = 0,
	SELECTION_MODE_EDGE = 1,
	SELECTION_MODE_FACE = 2,
}

var gizmo_size = 3.0

var vertices : PoolVector3Array
var indices : PoolIntArray

var handle_points : PoolVector3Array
var handle_to_vertex_map : Array

var selected_indices : PoolIntArray
var selected_vertices : PoolVector3Array
var selected_vertices_original : PoolVector3Array

var edit_mode = EditMode.TRANSLATE
var axis_constraint = AxisConstraint.X | AxisConstraint.Y | AxisConstraint.Z
var selection_mode = SelectionMode.SELECTION_MODE_VERTEX
var previous_point : Vector2
var is_dragging : bool = false

var _mdr : MeshDataResource = null

var _mesh_outline

func _init():
	_mesh_outline = MeshOutline.new()
	
func setup() -> void:
	get_spatial_node().connect("mesh_data_resource_changed", self, "on_mesh_data_resource_changed")
	on_mesh_data_resource_changed(get_spatial_node().mesh_data)

func set_handle(index: int, camera: Camera, point: Vector2):
	var relative : Vector2 = point - previous_point
	
	if !is_dragging:
		relative = Vector2()
		is_dragging = true
	
	if edit_mode == EditMode.NONE:
		return
	elif edit_mode == EditMode.TRANSLATE:
		var ofs : Vector3 = Vector3()

		if (axis_constraint & AxisConstraint.X) != 0:
			ofs.x = relative.x * 0.001 * sign(camera.get_global_transform().basis.z.z)
				
		if (axis_constraint & AxisConstraint.Y) != 0:
			ofs.y = relative.y * -0.001
				
		if (axis_constraint & AxisConstraint.Z) != 0:
			ofs.z = relative.x * 0.001  * -sign(camera.get_global_transform().basis.z.x)

		add_to_all_selected(ofs)

		redraw()
		apply()
	elif edit_mode == EditMode.SCALE:
		var r : float = 1.0 + ((relative.x + relative.y) * 0.05)
		
		var vs : Vector3 = Vector3()
		
		if (axis_constraint & AxisConstraint.X) != 0:
			vs.x = r
				
		if (axis_constraint & AxisConstraint.Y) != 0:
			vs.y = r
				
		if (axis_constraint & AxisConstraint.Z) != 0:
			vs.z = r
		
		var b : Basis = Basis().scaled(vs) 
		
		mul_all_selected_with_basis(b)

		redraw()
		apply()
	elif edit_mode == EditMode.ROTATE:
		print("ROTATE")
		
		
	previous_point = point

func commit_handle(index: int, restore, cancel: bool = false) -> void:
	previous_point = Vector2()
	
	print("commit")

func redraw():
	clear()
	
	if !_mdr:
		return
	
	if _mdr.array.size() != ArrayMesh.ARRAY_MAX:
		return
		
	var handles_material : SpatialMaterial = get_plugin().get_material("handles", self)
	var material = get_plugin().get_material("main", self)
	
	_mesh_outline.setup(_mdr)
	add_lines(_mesh_outline.lines, material, false)

	#displace selected handle verts too on drag, so this code just works.
	#draw handles though instead ov vertices
	
	var vs : PoolVector3Array = PoolVector3Array()
	
	for i in selected_indices:
		vs.append(vertices[i])
	
	add_handles(vs, handles_material)

func apply() -> void:
	if !_mdr:
		return
		
	var arrs : Array = _mdr.array
	arrs[ArrayMesh.ARRAY_VERTEX] = vertices
	_mdr.array = arrs


func forward_spatial_gui_input(index, camera, event):
	if event is InputEventMouseButton:
		var gt : Transform = get_spatial_node().global_transform
		var ray_from : Vector3 = camera.global_transform.origin
		var gpoint : Vector2 = event.get_position()
		var grab_threshold : float = 8
#		var grab_threshold : float = 4 * EDSCALE;

		if event.get_button_index() == BUTTON_LEFT:
			if event.is_pressed():
				var mouse_pos = event.get_position()
				
#				if (_gizmo_select(p_index, _edit.mouse_pos)) 
#					return true;

				# select vertex
				var closest_idx : int = -1
				var closest_dist : float = 1e10
				
				var vertices_size : int = vertices.size()
				for i in range(vertices_size):
					var vert_pos_3d : Vector3 = gt.xform(vertices[i])
					var vert_pos_2d : Vector2 = camera.unproject_position(vert_pos_3d)
					var dist_3d : float = ray_from.distance_to(vert_pos_3d)
					var dist_2d : float = gpoint.distance_to(vert_pos_2d)
					
					if (dist_2d < grab_threshold && dist_3d < closest_dist):
						closest_dist = dist_3d;
						closest_idx = i;

				if (closest_idx >= 0):
					for si in selected_indices:
						if si == closest_idx:
							return false
					
					var cv : Vector3 = vertices[closest_idx]
					selected_vertices.append(cv)
					selected_indices.append(closest_idx)
					
					selected_vertices_original.append(cv)
					
					#also find and mark duplicate vertices, but not as handles
					for k in range(vertices.size()):
						if k == closest_idx:
							continue
							
						var vn : Vector3 = vertices[k]
						
						if is_equal_approx(cv.x, vn.x) && is_equal_approx(cv.y, vn.y) && is_equal_approx(cv.z, vn.z):
							selected_indices.append(k)
							selected_vertices_original.append(vn)

					apply()
					redraw()
				else:
					selected_indices.resize(0)
					selected_vertices.resize(0)
					
					selected_vertices_original.resize(0)
					
					apply()
					redraw()
			else:
				is_dragging = false
					
#	elif event is InputEventMouseMotion:
#		if edit_mode == EditMode.NONE:
#			return false
#		elif edit_mode == EditMode.TRANSLATE:
#			for i in selected_indices:
#				var v : Vector3 = vertices[i]
#
#				if axis_constraint == AxisConstraint.X:
#					v.x += event.relative.x * -0.001
#				elif axis_constraint == AxisConstraint.Y:
#					v.y += event.relative.y * 0.001
#				elif axis_constraint == AxisConstraint.Z:
#					v.z += event.relative.x * 0.001
#
#				vertices.set(i, v)
#
#			redraw()
#		elif edit_mode == EditMode.SCALE:
#			print("SCALE")
#		elif edit_mode == EditMode.ROTATE:
#			print("ROTATE")
					
	return false

func add_to_all_selected(ofs : Vector3) -> void:
	for i in selected_indices:
		var v : Vector3 = vertices[i]
		v += ofs
		vertices.set(i, v)

func mul_all_selected_with_basis(b : Basis) -> void:
	for i in selected_indices:
		var v : Vector3 = vertices[i]
		v = b * v
		vertices.set(i, v)

func set_translate(on : bool) -> void:
	if on:
		edit_mode = EditMode.TRANSLATE
	
func set_scale(on : bool) -> void:
	if on:
		edit_mode = EditMode.SCALE
	
func set_rotate(on : bool) -> void:
	if on:
		edit_mode = EditMode.ROTATE
	
func set_axis_x(on : bool) -> void:
	if on:
		if (axis_constraint & AxisConstraint.X) != 0:
			axis_constraint ^= AxisConstraint.X
		else:
			axis_constraint |= AxisConstraint.X
	
func set_axis_y(on : bool) -> void:
	if on:
		if (axis_constraint & AxisConstraint.Y) != 0:
			axis_constraint ^= AxisConstraint.Y
		else:
			axis_constraint |= AxisConstraint.Y
	
func set_axis_z(on : bool) -> void:
	if on:
		if (axis_constraint & AxisConstraint.Z) != 0:
			axis_constraint ^= AxisConstraint.Z
		else:
			axis_constraint |= AxisConstraint.Z

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		if get_plugin():
			get_plugin().unregister_gizmo(self)

func on_mesh_data_resource_changed(mdr : MeshDataResource) -> void:

	#if changed recalc handles
	#if selection type changed recalc handles aswell
	#add method recalc handles -> check for type

	_mdr = mdr
	
	if _mdr && _mdr.array.size() == ArrayMesh.ARRAY_MAX && _mdr.array[ArrayMesh.ARRAY_VERTEX] != null:
		vertices = _mdr.array[ArrayMesh.ARRAY_VERTEX]
	else:
		vertices.resize(0)

	redraw()
