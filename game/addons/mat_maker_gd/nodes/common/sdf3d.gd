extends Reference

const Commons = preload("res://addons/mat_maker_gd/nodes/common/commons.gd")

static func raymarch(uv : Vector2) -> Color:
	var d : Vector2 = sdf3d_raymarch(uv);
	
	var f : float = 1.0 - d.x;
	
	return Color(f, f, f, 1)

static func raymarch2(uv : Vector2) -> Color:
	var d : Vector2 = sdf3d_raymarch(uv);
	
	var v : Vector3 = Vector3(0.5, 0.5, 0.5) + 0.5 * sdf3d_normal(Vector3(uv.x - 0.5, uv.y - 0.5, 1.0 - d.x));
	
	return Color(v.x, v.y, v.z, 1)

static func raymarch3(uv : Vector2) -> Color:
	var v : Vector2 = sdf3d_raymarch(uv);
	
	return Color(v.y, v.y, v.y, 1)

static func sdf3d_sphere(p : Vector3, r : float) -> Vector2:
	var s : float = p.length() - r;

	return Vector2(s, 0.0);

static func sdf3d_box(p : Vector3, sx : float, sy : float, sz : float, r : float) -> Vector2:
	var v : Vector3 = Commons.absv3((p)) - Vector3(sx, sy, sz);
	var f : float = (Commons.maxv3(v,Vector3())).length() + min(max(v.x,max(v.y, v.z)),0.0) - r;

	return Vector2(f, 0.0);

static func sdf3d_cylinder_y(p : Vector3, r : float, l : float) -> Vector2:
	var v : Vector2 = Commons.absv2(Vector2(Vector2(p.x, p.z).length(),(p).y)) - Vector2(r,l);
	var f : float = min(max(v.x, v.y),0.0) + Commons.maxv2(v, Vector2()).length();

	return Vector2(f, 0.0);

static func sdf3d_cylinder_x(p : Vector3, r : float, l : float) -> Vector2:
	var v : Vector2 = Commons.absv2(Vector2(Vector2(p.y, p.z).length(),(p).x)) - Vector2(r, l);
	var f : float = min(max(v.x, v.y),0.0) + Commons.maxv2(v, Vector2()).length();

	return Vector2(f, 0.0);

static func sdf3d_cylinder_z(p : Vector3, r : float, l : float) -> Vector2:
	var v : Vector2 = Commons.absv2(Vector2(Vector2(p.x, p.y).length(),(p).z)) - Vector2(r, l);
	var f : float = min(max(v.x, v.y),0.0) + Commons.maxv2(v, Vector2()).length();

	return Vector2(f, 0.0);

static func sdf3d_capsule_y(p : Vector3, r : float, l : float) -> Vector2:
	var v : Vector3 = p;
	v.y -= clamp(v.y, -l, l);
	var f : float = v.length() - r;

	return Vector2(f, 0.0);

static func sdf3d_capsule_x(p : Vector3, r : float, l : float) -> Vector2:
	var v : Vector3 = p;
	v.x -= clamp(v.x, -l, l);
	var f : float = v.length() - r;

	return Vector2(f, 0.0);

static func sdf3d_capsule_z(p : Vector3, r : float, l : float) -> Vector2:
	var v : Vector3 = p;
	v.z -= clamp(v.z, -l, l);
	var f : float = v.length() - r;

	return Vector2(f, 0.0);

var p_o118934_a = 30.000000000;

static func sdf3d_cone_px(p : Vector3, a : float) -> Vector2:
	var  f : float = Vector2(cos(a*0.01745329251),sin(a*0.01745329251)).dot(Vector2(Vector2(p.y, p.z).length(), - (p).x));

	return Vector2(f, 0.0);

static func sdf3d_cone_nx(p : Vector3, a : float) -> Vector2:
	var  f : float = Vector2(cos(a*0.01745329251),sin(a*0.01745329251)).dot(Vector2(Vector2(p.y, p.z).length(),(p).x));

	return Vector2(f, 0.0);

static func sdf3d_cone_py(p : Vector3, a : float) -> Vector2:
	var  f : float = Vector2(cos(a*0.01745329251),sin(a*0.01745329251)).dot(Vector2(Vector2(p.x, p.z).length(),(p).y));

	return Vector2(f, 0.0);

static func sdf3d_cone_ny(p : Vector3, a : float) -> Vector2:
	var  f : float = Vector2(cos(a*0.01745329251),sin(a*0.01745329251)).dot(Vector2(Vector2(p.x, p.z).length(),-(p).y));

	return Vector2(f, 0.0);

static func sdf3d_cone_pz(p : Vector3, a : float) -> Vector2:
	var  f : float = Vector2(cos(a*0.01745329251),sin(a*0.01745329251)).dot(Vector2(Vector2(p.x, p.y).length(),-(p).z));

	return Vector2(f, 0.0);

static func sdf3d_cone_nz(p : Vector3, a : float) -> Vector2:
	var f : float = Vector2(cos(a*0.01745329251),sin(a*0.01745329251)).dot(Vector2(Vector2(p.x, p.y).length(),(p).z));

	return Vector2(f, 0.0);

static func sdf3d_torus_x(p : Vector3, R : float, r : float) -> Vector2:
	var q : Vector2 = Vector2(Vector2(p.y, p.z).length() - R,(p).x);
	var f : float = q.length() - r;

	return Vector2(f, 0.0);
	
static func sdf3d_torus_y(p : Vector3, R : float, r : float) -> Vector2:
	var q : Vector2 = Vector2(Vector2(p.z, p.x).length() - R,(p).y);
	var f : float = q.length() - r;

	return Vector2(f, 0.0);

static func sdf3d_torus_z(p : Vector3, R : float, r : float) -> Vector2:
	var q : Vector2 = Vector2(Vector2(p.x, p.y).length() - R,(p).z);
	var f : float = q.length() - r;

	return Vector2(f, 0.0);

static func sdf3d_raymarch(uv : Vector2) -> Vector2:
	var ro : Vector3 = Vector3(uv.x - 0.5, uv.y - 0.5, 1.0);
	var rd : Vector3 = Vector3(0.0, 0.0, -1.0);
	var dO : float = 0.0;
	var c : float = 0.0;
	
	for i in range(100):
		var p : Vector3 = ro + rd * dO;
		var dS : Vector2 = sdf3d_input(p);
		
		dO += dS.x;

		if (dO >= 1.0):
			break;
		elif (dS.x < 0.0001):
			c = dS.y;
			break;
	
	return Vector2(dO, c);

static func sdf3d_normal(p : Vector3) -> Vector3:
	if (p.z <= 0.0):
		return Vector3(0.0, 0.0, 1.0);

	var d : float = sdf3d_input(p).x;
	var e : float = .001;
	
	var n : Vector3 = Vector3(
		d - sdf3d_input(p - Vector3(e, 0.0, 0.0)).x,
		d - sdf3d_input(p - Vector3(0.0, e, 0.0)).x,
		d - sdf3d_input(p - Vector3(0.0, 0.0, e)).x);
	
	return Vector3(-1.0, -1.0, -1.0) * n.normalized();
	
static func sdf3dc_union(a : Vector2, b : Vector2) -> Vector2:
	return Vector2(min(a.x, b.x), lerp(b.y, a.y, Commons.step(a.x, b.x)));

static func sdf3dc_sub(a : Vector2, b : Vector2) -> Vector2:
	return Vector2(max(-a.x, b.x), a.y);

static func sdf3dc_inter(a : Vector2, b : Vector2) -> Vector2:
	return Vector2(max(a.x, b.x), lerp(a.y, b.y, Commons.step(a.x, b.x)));

static func sdf3d_smooth_union(d1 : Vector2, d2 : Vector2, k : float) -> Vector2:
	var h : float = clamp(0.5 + 0.5 * (d2.x - d1.x) / k, 0.0, 1.0);
	return Vector2(lerp(d2.x, d1.x, h)-k*h*(1.0 - h), lerp(d2.y, d1.y, Commons.step(d1.x, d2.x)));

static func sdf3d_smooth_subtraction(d1 : Vector2, d2 : Vector2, k : float) -> Vector2:
	var h : float = clamp(0.5 - 0.5 * (d2.x + d1.x) / k, 0.0, 1.0);
	return Vector2(lerp(d2.x, -d1.x, h )+k*h*(1.0-h), d2.y);

static func sdf3d_smooth_intersection(d1 : Vector2, d2 : Vector2, k : float) -> Vector2:
	var h : float = clamp(0.5 - 0.5 * (d2.x - d1.x) / k, 0.0, 1.0);
	return Vector2(lerp(d2.x, d1.x, h)+k*h*(1.0-h), lerp(d1.y, d2.y, Commons.step(d1.x, d2.x)));

static func sdf3d_rounded(v : Vector2, r : float) -> Vector2:
	return Vector2(v.x - r, v.y);

static func sdf3d_elongation(p : Vector3, v : Vector3) -> Vector3:
	return ((p) - Commons.clampv3((p), - Commons.absv3(v), Commons.absv3(v)))

static func sdf3d_repeat(p : Vector3, r : Vector2, randomness : float, pseed : int) -> Vector3:
	return (repeat(p, Vector3(1.0/r.x, 1.0/r.y, 0.00001), float(pseed), randomness))

#Needs work
static func repeat(p : Vector3, r : Vector3, pseed : float, randomness : float) -> Vector3:
	#fix division by zero
#	p.x += 0.000001
#	p.y += 0.000001
#	p.z += 0.000001
#	r.x += 0.000001
#	r.y += 0.000001
#	r.z += 0.000001
	
	var pxy : Vector2 = Vector2(p.x, p.y)
	var rxy : Vector2 = Vector2(r.x, r.y)
	
	var r3 : Vector2 = Commons.floorv2(Commons.modv2((pxy + 0.5 * rxy) / rxy, Vector2(1.0 / rxy.x, 1.0 / rxy.y)) + Vector2(pseed, pseed))
	
	var rr : Vector3 = Commons.rand3(r3)
	
	rr.x -= 0.5
	rr.y -= 0.5
	rr.z -= 0.5
	
	var a : Vector3 = (rr) * 6.28 * randomness;

	p = Commons.modv3(p + 0.5 * r, r) - 0.5*r;
	var rv : Vector3;
	var c : float;
	var s : float;
	
	c = cos(a.x);
	s = sin(a.x);
	rv.x = p.x;
	rv.y = p.y*c+p.z*s;
	rv.z = -p.y*s+p.z*c;
	c = cos(a.y);
	s = sin(a.y);
	p.x = rv.x*c+rv.z*s;
	p.y = rv.y;
	p.z = -rv.x*s+rv.z*c;
	c = cos(a.z);
	s = sin(a.z);
	rv.x = p.x*c+p.y*s;
	rv.y = -p.x*s+p.y*c;
	rv.z = p.z;
	
	return rv;
	
#todo this needs to be solved
static func sdf3d_input(p : Vector3) -> Vector2:
	return sdf3d_sphere(p, 0.5)
