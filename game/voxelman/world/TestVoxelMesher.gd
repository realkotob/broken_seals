extends VoxelMesherMarchingCubes
class_name TestVoxelMesher

# Copyright Péter Magyar relintai@gmail.com
# MIT License, might be merged into the Voxelman engine module

# Copyright (c) 2019-2020 Péter Magyar

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

var count : int = 0

var regular_uv_entries : Array = [
	[ 0, 0 ], #0
	[ 1, 0 ], #1
	[ 0, 1 ], #2
	[ 1, 1 ], #3
]

var regular_uv_data : Array = [
	[],
	#[ 0x6201, 0x5102, 0x3304 ],
	[ 2, 1, 3 ], #h top s, n, s
	#[ 0x6201, 0x2315, 0x4113 ],
	[ 2, 1, 0 ], #h top s, s, n
	#[ 0x5102, 0x3304, 0x2315, 0x4113 ],
	[ 0, 1, 2, 3 ], #h top n, s, s, n
	#[ 0x5102, 0x4223, 0x1326 ],
	[ 2, 3, 5 ],  #h top
	#[ 0x3304, 0x6201, 0x4223, 0x1326 ],
	[ 2, 3, 1, 0 ], #h top
	#[ 0x6201, 0x2315, 0x4113, 0x5102, 0x4223, 0x1326 ],
	[ 2, 3, 1, 2, 1, 0 ], #h top
	#[ 0x4223, 0x1326, 0x3304, 0x2315, 0x4113 ],
	[ 3, 1, 0, 2, 3 ], #h top
	#[ 0x4113, 0x8337, 0x4223 ],
	[ 3, 1, 0 ], #h top
	#[ 0x6201, 0x5102, 0x3304, 0x4223, 0x4113, 0x8337 ],
	[ 3, 0, 2, 0, 3, 1 ], #h top
	#[ 0x6201, 0x2315, 0x8337, 0x4223 ],
	[ 2, 3, 1, 0 ], #h top
	#[ 0x5102, 0x3304, 0x2315, 0x8337, 0x4223 ],
	[ 0, 2, 3, 1, 0 ], #h top
	#[ 0x5102, 0x4113, 0x8337, 0x1326 ],
	[ 2, 3, 1, 0 ], #h top s, s, n, n
	#[ 0x4113, 0x8337, 0x1326, 0x3304, 0x6201 ],
	[ 3, 1, 0, 2, 2 ], #h top s, n, n, n, s
	#[ 0x6201, 0x2315, 0x8337, 0x1326, 0x5102 ],
	[ 2, 3, 1, 0, 2 ], #h top s, n, n, n, s
	#[ 0x3304, 0x2315, 0x8337, 0x1326 ],
	[ 2, 3, 1, 0 ], #h top n, n, n, n
	#[ 0x3304, 0x1146, 0x2245 ],
	[ 2, 0, 3 ], # h bottom n, s, s
	#[ 0x6201, 0x5102, 0x1146, 0x2245 ],
	[ 0, 1, 2, 3 ],
	[ 0x6201, 0x2315, 0x4113, 0x3304, 0x1146, 0x2245 ],
	[ 0x2315, 0x4113, 0x5102, 0x1146, 0x2245 ],
	[ 0x5102, 0x4223, 0x1326, 0x3304, 0x1146, 0x2245 ],
	[ 0x1146, 0x2245, 0x6201, 0x4223, 0x1326 ],
	[ 0x3304, 0x1146, 0x2245, 0x6201, 0x2315, 0x4113, 0x5102, 0x4223, 0x1326 ],
	[ 0x4223, 0x1326, 0x1146, 0x2245, 0x2315, 0x4113 ],
	[ 0x4223, 0x4113, 0x8337, 0x3304, 0x1146, 0x2245 ],
	[ 0x6201, 0x5102, 0x1146, 0x2245, 0x4223, 0x4113, 0x8337 ],
	[ 0x4223, 0x6201, 0x2315, 0x8337, 0x3304, 0x1146, 0x2245 ],
	[ 0x4223, 0x8337, 0x2315, 0x2245, 0x1146, 0x5102 ],
	[ 0x5102, 0x4113, 0x8337, 0x1326, 0x3304, 0x1146, 0x2245 ],
	[ 0x4113, 0x8337, 0x1326, 0x1146, 0x2245, 0x6201 ],
	[ 0x6201, 0x2315, 0x8337, 0x1326, 0x5102, 0x3304, 0x1146, 0x2245 ],
	[ 0x2245, 0x2315, 0x8337, 0x1326, 0x1146 ],
	#[ 0x2315, 0x2245, 0x8157 ],
	[ 0, 1, 4 ],
	[ 0x6201, 0x5102, 0x3304, 0x2315, 0x2245, 0x8157 ],
	#[ 0x4113, 0x6201, 0x2245, 0x8157 ],
	[ 0, 1, 2, 3 ],
	[ 0x2245, 0x8157, 0x4113, 0x5102, 0x3304 ],
	[ 0x5102, 0x4223, 0x1326, 0x2315, 0x2245, 0x8157 ],
	[ 0x6201, 0x4223, 0x1326, 0x3304, 0x2315, 0x2245, 0x8157 ],
	[ 0x6201, 0x2245, 0x8157, 0x4113, 0x5102, 0x4223, 0x1326 ],
	[ 0x4223, 0x1326, 0x3304, 0x2245, 0x8157, 0x4113 ],
	[ 0x4223, 0x4113, 0x8337, 0x2315, 0x2245, 0x8157 ],
	[ 0x6201, 0x5102, 0x3304, 0x4223, 0x4113, 0x8337, 0x2315, 0x2245, 0x8157 ],
	[ 0x8337, 0x4223, 0x6201, 0x2245, 0x8157 ],
	[ 0x5102, 0x3304, 0x2245, 0x8157, 0x8337, 0x4223 ],
	[ 0x5102, 0x4113, 0x8337, 0x1326, 0x2315, 0x2245, 0x8157 ],
	[ 0x4113, 0x8337, 0x1326, 0x3304, 0x6201, 0x2315, 0x2245, 0x8157 ],
	[ 0x5102, 0x1326, 0x8337, 0x8157, 0x2245, 0x6201 ],
	[ 0x8157, 0x8337, 0x1326, 0x3304, 0x2245 ],
	#[ 0x2315, 0x3304, 0x1146, 0x8157 ],
	[ 0, 1, 2, 3 ],
	[ 0x6201, 0x5102, 0x1146, 0x8157, 0x2315 ],
	[ 0x3304, 0x1146, 0x8157, 0x4113, 0x6201 ],
	#[ 0x4113, 0x5102, 0x1146, 0x8157 ],
	[ 0, 1, 2, 3 ],
	[ 0x2315, 0x3304, 0x1146, 0x8157, 0x5102, 0x4223, 0x1326 ],
	[ 0x1326, 0x4223, 0x6201, 0x2315, 0x8157, 0x1146 ],
	[ 0x3304, 0x1146, 0x8157, 0x4113, 0x6201, 0x5102, 0x4223, 0x1326 ],
	[ 0x1326, 0x1146, 0x8157, 0x4113, 0x4223 ],
	[ 0x2315, 0x3304, 0x1146, 0x8157, 0x4223, 0x4113, 0x8337 ],
	[ 0x6201, 0x5102, 0x1146, 0x8157, 0x2315, 0x4223, 0x4113, 0x8337 ],
	[ 0x3304, 0x1146, 0x8157, 0x8337, 0x4223, 0x6201 ],
	[ 0x4223, 0x5102, 0x1146, 0x8157, 0x8337 ],
	[ 0x2315, 0x3304, 0x1146, 0x8157, 0x5102, 0x4113, 0x8337, 0x1326 ],
	[ 0x6201, 0x4113, 0x8337, 0x1326, 0x1146, 0x8157, 0x2315 ],
	[ 0x6201, 0x3304, 0x1146, 0x8157, 0x8337, 0x1326, 0x5102 ],
	#[ 0x1326, 0x1146, 0x8157, 0x8337 ],
	[ 0, 1, 2, 3 ],
	#[ 0x1326, 0x8267, 0x1146 ],
	[ 0, 1, 4 ],
	[ 0x6201, 0x5102, 0x3304, 0x1326, 0x8267, 0x1146 ],
	[ 0x6201, 0x2315, 0x4113, 0x1326, 0x8267, 0x1146 ],
	[ 0x5102, 0x3304, 0x2315, 0x4113, 0x1326, 0x8267, 0x1146 ],
	#[ 0x5102, 0x4223, 0x8267, 0x1146 ],
	[ 0, 1, 2, 3 ],
	[ 0x3304, 0x6201, 0x4223, 0x8267, 0x1146 ],
	[ 0x5102, 0x4223, 0x8267, 0x1146, 0x6201, 0x2315, 0x4113 ],
	[ 0x1146, 0x8267, 0x4223, 0x4113, 0x2315, 0x3304 ],
	[ 0x4113, 0x8337, 0x4223, 0x1326, 0x8267, 0x1146 ],
	[ 0x6201, 0x5102, 0x3304, 0x4223, 0x4113, 0x8337, 0x1326, 0x8267, 0x1146 ],
	[ 0x6201, 0x2315, 0x8337, 0x4223, 0x1326, 0x8267, 0x1146 ],
	[ 0x5102, 0x3304, 0x2315, 0x8337, 0x4223, 0x1326, 0x8267, 0x1146 ],
	[ 0x8267, 0x1146, 0x5102, 0x4113, 0x8337 ],
	[ 0x6201, 0x4113, 0x8337, 0x8267, 0x1146, 0x3304 ],
	[ 0x6201, 0x2315, 0x8337, 0x8267, 0x1146, 0x5102 ],
	[ 0x1146, 0x3304, 0x2315, 0x8337, 0x8267 ],
	#[ 0x3304, 0x1326, 0x8267, 0x2245 ],
	[ 0, 1, 2, 3 ],
	[ 0x1326, 0x8267, 0x2245, 0x6201, 0x5102 ],
	[ 0x3304, 0x1326, 0x8267, 0x2245, 0x6201, 0x2315, 0x4113 ],
	[ 0x1326, 0x8267, 0x2245, 0x2315, 0x4113, 0x5102 ],
	[ 0x5102, 0x4223, 0x8267, 0x2245, 0x3304 ],
	#[ 0x6201, 0x4223, 0x8267, 0x2245 ],
	[ 0, 1, 2, 3 ],
	[ 0x5102, 0x4223, 0x8267, 0x2245, 0x3304, 0x6201, 0x2315, 0x4113 ],
	[ 0x4113, 0x4223, 0x8267, 0x2245, 0x2315 ],
	[ 0x3304, 0x1326, 0x8267, 0x2245, 0x4223, 0x4113, 0x8337 ],
	[ 0x1326, 0x8267, 0x2245, 0x6201, 0x5102, 0x4223, 0x4113, 0x8337 ],
	[ 0x3304, 0x1326, 0x8267, 0x2245, 0x4223, 0x6201, 0x2315, 0x8337 ],
	[ 0x5102, 0x1326, 0x8267, 0x2245, 0x2315, 0x8337, 0x4223 ],
	[ 0x3304, 0x2245, 0x8267, 0x8337, 0x4113, 0x5102 ],
	[ 0x8337, 0x8267, 0x2245, 0x6201, 0x4113 ],
	[ 0x5102, 0x6201, 0x2315, 0x8337, 0x8267, 0x2245, 0x3304 ],
	#[ 0x2315, 0x8337, 0x8267, 0x2245 ],
	[ 0, 1, 2, 3 ],
	[ 0x2315, 0x2245, 0x8157, 0x1326, 0x8267, 0x1146 ],
	[ 0x6201, 0x5102, 0x3304, 0x2315, 0x2245, 0x8157, 0x1326, 0x8267, 0x1146 ],
	[ 0x6201, 0x2245, 0x8157, 0x4113, 0x1326, 0x8267, 0x1146 ],
	[ 0x2245, 0x8157, 0x4113, 0x5102, 0x3304, 0x1326, 0x8267, 0x1146 ],
	[ 0x4223, 0x8267, 0x1146, 0x5102, 0x2315, 0x2245, 0x8157 ],
	[ 0x3304, 0x6201, 0x4223, 0x8267, 0x1146, 0x2315, 0x2245, 0x8157 ],
	[ 0x4223, 0x8267, 0x1146, 0x5102, 0x6201, 0x2245, 0x8157, 0x4113 ],
	[ 0x3304, 0x2245, 0x8157, 0x4113, 0x4223, 0x8267, 0x1146 ],
	[ 0x4223, 0x4113, 0x8337, 0x2315, 0x2245, 0x8157, 0x1326, 0x8267, 0x1146 ],
	[ 0x6201, 0x5102, 0x3304, 0x4223, 0x4113, 0x8337, 0x2315, 0x2245, 0x8157, 0x1326, 0x8267, 0x1146 ],
	[ 0x8337, 0x4223, 0x6201, 0x2245, 0x8157, 0x1326, 0x8267, 0x1146 ],
	[ 0x4223, 0x5102, 0x3304, 0x2245, 0x8157, 0x8337, 0x1326, 0x8267, 0x1146 ],
	[ 0x8267, 0x1146, 0x5102, 0x4113, 0x8337, 0x2315, 0x2245, 0x8157 ],
	[ 0x6201, 0x4113, 0x8337, 0x8267, 0x1146, 0x3304, 0x2315, 0x2245, 0x8157 ],
	[ 0x8337, 0x8267, 0x1146, 0x5102, 0x6201, 0x2245, 0x8157 ],
	[ 0x3304, 0x2245, 0x8157, 0x8337, 0x8267, 0x1146 ],
	[ 0x8157, 0x2315, 0x3304, 0x1326, 0x8267 ],
	[ 0x8267, 0x8157, 0x2315, 0x6201, 0x5102, 0x1326 ],
	[ 0x8267, 0x1326, 0x3304, 0x6201, 0x4113, 0x8157 ],
	[ 0x8267, 0x8157, 0x4113, 0x5102, 0x1326 ],
	[ 0x5102, 0x4223, 0x8267, 0x8157, 0x2315, 0x3304 ],
	[ 0x2315, 0x6201, 0x4223, 0x8267, 0x8157 ],
	[ 0x3304, 0x5102, 0x4223, 0x8267, 0x8157, 0x4113, 0x6201 ],
	#[ 0x4113, 0x4223, 0x8267, 0x8157 ],
	[ 0, 1, 2, 3 ],
	[ 0x8157, 0x2315, 0x3304, 0x1326, 0x8267, 0x4223, 0x4113, 0x8337 ],
	[ 0x8157, 0x2315, 0x6201, 0x5102, 0x1326, 0x8267, 0x4223, 0x4113, 0x8337 ],
	[ 0x8157, 0x8337, 0x4223, 0x6201, 0x3304, 0x1326, 0x8267 ],
	[ 0x5102, 0x1326, 0x8267, 0x8157, 0x8337, 0x4223 ],
	[ 0x8267, 0x8157, 0x2315, 0x3304, 0x5102, 0x4113, 0x8337 ],
	[ 0x6201, 0x4113, 0x8337, 0x8267, 0x8157, 0x2315 ],
	[ 0x6201, 0x3304, 0x5102, 0x8337, 0x8267, 0x8157 ],
	#[ 0x8337, 0x8267, 0x8157 ],
	#[ 0x8337, 0x8157, 0x8267 ],
	[ 0, 1, 4 ],
	[ 0, 1, 4 ],
	[ 0x6201, 0x5102, 0x3304, 0x8337, 0x8157, 0x8267 ],
	[ 0x6201, 0x2315, 0x4113, 0x8337, 0x8157, 0x8267 ],
	[ 0x5102, 0x3304, 0x2315, 0x4113, 0x8337, 0x8157, 0x8267 ],
	[ 0x5102, 0x4223, 0x1326, 0x8337, 0x8157, 0x8267 ],
	[ 0x6201, 0x4223, 0x1326, 0x3304, 0x8337, 0x8157, 0x8267 ],
	[ 0x6201, 0x2315, 0x4113, 0x5102, 0x4223, 0x1326, 0x8337, 0x8157, 0x8267 ],
	[ 0x4223, 0x1326, 0x3304, 0x2315, 0x4113, 0x8337, 0x8157, 0x8267 ],
	#[ 0x4113, 0x8157, 0x8267, 0x4223 ],
	[ 0, 1, 2, 3 ],
	[ 0x4223, 0x4113, 0x8157, 0x8267, 0x6201, 0x5102, 0x3304 ],
	[ 0x8157, 0x8267, 0x4223, 0x6201, 0x2315 ],
	[ 0x3304, 0x2315, 0x8157, 0x8267, 0x4223, 0x5102 ],
	[ 0x1326, 0x5102, 0x4113, 0x8157, 0x8267 ],
	[ 0x8157, 0x4113, 0x6201, 0x3304, 0x1326, 0x8267 ],
	[ 0x1326, 0x5102, 0x6201, 0x2315, 0x8157, 0x8267 ],
	[ 0x8267, 0x1326, 0x3304, 0x2315, 0x8157 ],
	[ 0x3304, 0x1146, 0x2245, 0x8337, 0x8157, 0x8267 ],
	[ 0x6201, 0x5102, 0x1146, 0x2245, 0x8337, 0x8157, 0x8267 ],
	[ 0x6201, 0x2315, 0x4113, 0x3304, 0x1146, 0x2245, 0x8337, 0x8157, 0x8267 ],
	[ 0x2315, 0x4113, 0x5102, 0x1146, 0x2245, 0x8337, 0x8157, 0x8267 ],
	[ 0x5102, 0x4223, 0x1326, 0x3304, 0x1146, 0x2245, 0x8337, 0x8157, 0x8267 ],
	[ 0x1146, 0x2245, 0x6201, 0x4223, 0x1326, 0x8337, 0x8157, 0x8267 ],
	[ 0x6201, 0x2315, 0x4113, 0x5102, 0x4223, 0x1326, 0x3304, 0x1146, 0x2245, 0x8337, 0x8157, 0x8267 ],
	[ 0x4113, 0x4223, 0x1326, 0x1146, 0x2245, 0x2315, 0x8337, 0x8157, 0x8267 ],
	[ 0x4223, 0x4113, 0x8157, 0x8267, 0x3304, 0x1146, 0x2245 ],
	[ 0x6201, 0x5102, 0x1146, 0x2245, 0x4223, 0x4113, 0x8157, 0x8267 ],
	[ 0x8157, 0x8267, 0x4223, 0x6201, 0x2315, 0x3304, 0x1146, 0x2245 ],
	[ 0x2315, 0x8157, 0x8267, 0x4223, 0x5102, 0x1146, 0x2245 ],
	[ 0x1326, 0x5102, 0x4113, 0x8157, 0x8267, 0x3304, 0x1146, 0x2245 ],
	[ 0x1326, 0x1146, 0x2245, 0x6201, 0x4113, 0x8157, 0x8267 ],
	[ 0x5102, 0x6201, 0x2315, 0x8157, 0x8267, 0x1326, 0x3304, 0x1146, 0x2245 ],
	[ 0x1326, 0x1146, 0x2245, 0x2315, 0x8157, 0x8267 ],
	#[ 0x2315, 0x2245, 0x8267, 0x8337 ],
	[ 0, 1, 2, 3 ],
	[ 0x2315, 0x2245, 0x8267, 0x8337, 0x6201, 0x5102, 0x3304 ],
	[ 0x4113, 0x6201, 0x2245, 0x8267, 0x8337 ],
	[ 0x5102, 0x4113, 0x8337, 0x8267, 0x2245, 0x3304 ],
	[ 0x2315, 0x2245, 0x8267, 0x8337, 0x5102, 0x4223, 0x1326 ],
	[ 0x6201, 0x4223, 0x1326, 0x3304, 0x8337, 0x2315, 0x2245, 0x8267 ],
	[ 0x4113, 0x6201, 0x2245, 0x8267, 0x8337, 0x5102, 0x4223, 0x1326 ],
	[ 0x4113, 0x4223, 0x1326, 0x3304, 0x2245, 0x8267, 0x8337 ],
	[ 0x2315, 0x2245, 0x8267, 0x4223, 0x4113 ],
	[ 0x2315, 0x2245, 0x8267, 0x4223, 0x4113, 0x6201, 0x5102, 0x3304 ],
	#[ 0x6201, 0x2245, 0x8267, 0x4223 ],
	[ 0, 1, 2, 3 ],
	[ 0x3304, 0x2245, 0x8267, 0x4223, 0x5102 ],
	[ 0x5102, 0x4113, 0x2315, 0x2245, 0x8267, 0x1326 ],
	[ 0x4113, 0x2315, 0x2245, 0x8267, 0x1326, 0x3304, 0x6201 ],
	[ 0x5102, 0x6201, 0x2245, 0x8267, 0x1326 ],
	#[ 0x3304, 0x2245, 0x8267, 0x1326 ],
	[ 0, 1, 2, 3 ],
	[ 0x8267, 0x8337, 0x2315, 0x3304, 0x1146 ],
	[ 0x5102, 0x1146, 0x8267, 0x8337, 0x2315, 0x6201 ],
	[ 0x3304, 0x1146, 0x8267, 0x8337, 0x4113, 0x6201 ],
	[ 0x8337, 0x4113, 0x5102, 0x1146, 0x8267 ],
	[ 0x8267, 0x8337, 0x2315, 0x3304, 0x1146, 0x5102, 0x4223, 0x1326 ],
	[ 0x1146, 0x8267, 0x8337, 0x2315, 0x6201, 0x4223, 0x1326 ],
	[ 0x8267, 0x8337, 0x4113, 0x6201, 0x3304, 0x1146, 0x5102, 0x4223, 0x1326 ],
	[ 0x4113, 0x4223, 0x1326, 0x1146, 0x8267, 0x8337 ],
	[ 0x3304, 0x2315, 0x4113, 0x4223, 0x8267, 0x1146 ],
	[ 0x2315, 0x6201, 0x5102, 0x1146, 0x8267, 0x4223, 0x4113 ],
	[ 0x1146, 0x8267, 0x4223, 0x6201, 0x3304 ],
	#[ 0x5102, 0x1146, 0x8267, 0x4223 ],
	[ 0, 1, 2, 3 ],
	[ 0x8267, 0x1326, 0x5102, 0x4113, 0x2315, 0x3304, 0x1146 ],
	[ 0x6201, 0x4113, 0x2315, 0x1326, 0x1146, 0x8267 ],
	[ 0x6201, 0x3304, 0x1146, 0x8267, 0x1326, 0x5102 ],
	#[ 0x1326, 0x1146, 0x8267 ],
	[ 0, 1, 4 ],
	#[ 0x1326, 0x8337, 0x8157, 0x1146 ],
	[ 0, 1, 2, 3 ],
	[ 0x8337, 0x8157, 0x1146, 0x1326, 0x6201, 0x5102, 0x3304 ],
	[ 0x8337, 0x8157, 0x1146, 0x1326, 0x6201, 0x2315, 0x4113 ],
	[ 0x4113, 0x5102, 0x3304, 0x2315, 0x1326, 0x8337, 0x8157, 0x1146 ],
	[ 0x8337, 0x8157, 0x1146, 0x5102, 0x4223 ],
	[ 0x6201, 0x4223, 0x8337, 0x8157, 0x1146, 0x3304 ],
	[ 0x8337, 0x8157, 0x1146, 0x5102, 0x4223, 0x6201, 0x2315, 0x4113 ],
	[ 0x4223, 0x8337, 0x8157, 0x1146, 0x3304, 0x2315, 0x4113 ],
	[ 0x4223, 0x4113, 0x8157, 0x1146, 0x1326 ],
	[ 0x4223, 0x4113, 0x8157, 0x1146, 0x1326, 0x6201, 0x5102, 0x3304 ],
	[ 0x1146, 0x8157, 0x2315, 0x6201, 0x4223, 0x1326 ],
	[ 0x4223, 0x5102, 0x3304, 0x2315, 0x8157, 0x1146, 0x1326 ],
	#[ 0x4113, 0x8157, 0x1146, 0x5102 ],
	[ 0, 1, 2, 3 ],
	[ 0x6201, 0x4113, 0x8157, 0x1146, 0x3304 ],
	[ 0x2315, 0x8157, 0x1146, 0x5102, 0x6201 ],
	#[ 0x2315, 0x8157, 0x1146, 0x3304 ],
	[ 0, 1, 2, 3 ],
	[ 0x2245, 0x3304, 0x1326, 0x8337, 0x8157 ],
	[ 0x6201, 0x2245, 0x8157, 0x8337, 0x1326, 0x5102 ],
	[ 0x2245, 0x3304, 0x1326, 0x8337, 0x8157, 0x6201, 0x2315, 0x4113 ],
	[ 0x2245, 0x2315, 0x4113, 0x5102, 0x1326, 0x8337, 0x8157 ],
	[ 0x4223, 0x8337, 0x8157, 0x2245, 0x3304, 0x5102 ],
	[ 0x8157, 0x2245, 0x6201, 0x4223, 0x8337 ],
	[ 0x2245, 0x3304, 0x5102, 0x4223, 0x8337, 0x8157, 0x4113, 0x6201, 0x2315 ],
	[ 0x4223, 0x8337, 0x8157, 0x2245, 0x2315, 0x4113 ],
	[ 0x4113, 0x8157, 0x2245, 0x3304, 0x1326, 0x4223 ],
	[ 0x1326, 0x4223, 0x4113, 0x8157, 0x2245, 0x6201, 0x5102 ],
	[ 0x8157, 0x2245, 0x3304, 0x1326, 0x4223, 0x6201, 0x2315 ],
	[ 0x5102, 0x1326, 0x4223, 0x2315, 0x8157, 0x2245 ],
	[ 0x3304, 0x5102, 0x4113, 0x8157, 0x2245 ],
	#[ 0x4113, 0x8157, 0x2245, 0x6201 ],
	[ 0, 1, 2, 3 ],
	[ 0x5102, 0x6201, 0x2315, 0x8157, 0x2245, 0x3304 ],
	#[ 0x2315, 0x8157, 0x2245 ],
	[ 0, 1, 4 ],
	[ 0x1146, 0x1326, 0x8337, 0x2315, 0x2245 ],
	[ 0x1146, 0x1326, 0x8337, 0x2315, 0x2245, 0x6201, 0x5102, 0x3304 ],
	[ 0x6201, 0x2245, 0x1146, 0x1326, 0x8337, 0x4113 ],
	[ 0x2245, 0x1146, 0x1326, 0x8337, 0x4113, 0x5102, 0x3304 ],
	[ 0x5102, 0x1146, 0x2245, 0x2315, 0x8337, 0x4223 ],
	[ 0x1146, 0x3304, 0x6201, 0x4223, 0x8337, 0x2315, 0x2245 ],
	[ 0x8337, 0x4113, 0x6201, 0x2245, 0x1146, 0x5102, 0x4223 ],
	[ 0x4223, 0x8337, 0x4113, 0x3304, 0x2245, 0x1146 ],
	[ 0x4113, 0x2315, 0x2245, 0x1146, 0x1326, 0x4223 ],
	[ 0x1146, 0x1326, 0x4223, 0x4113, 0x2315, 0x2245, 0x6201, 0x5102, 0x3304 ],
	[ 0x1326, 0x4223, 0x6201, 0x2245, 0x1146 ],
	[ 0x4223, 0x5102, 0x3304, 0x2245, 0x1146, 0x1326 ],
	[ 0x2245, 0x1146, 0x5102, 0x4113, 0x2315 ],
	[ 0x4113, 0x2315, 0x2245, 0x1146, 0x3304, 0x6201 ],
	#[ 0x6201, 0x2245, 0x1146, 0x5102 ],
	[ 0, 1, 2, 3 ],
	#[ 0x3304, 0x2245, 0x1146 ],
	[ 0, 1, 4 ],
	#[ 0x3304, 0x1326, 0x8337, 0x2315 ],
	[ 0, 1, 2, 3 ],
	[ 0x5102, 0x1326, 0x8337, 0x2315, 0x6201 ],
	[ 0x6201, 0x3304, 0x1326, 0x8337, 0x4113 ],
	#[ 0x5102, 0x1326, 0x8337, 0x4113 ],
	[ 0, 1, 2, 3 ],
	[ 0x4223, 0x8337, 0x2315, 0x3304, 0x5102 ],
	#[ 0x6201, 0x4223, 0x8337, 0x2315 ],
	[ 0, 1, 2, 3 ],
	[ 0x3304, 0x5102, 0x4223, 0x8337, 0x4113, 0x6201 ],
	#[ 0x4113, 0x4223, 0x8337 ],
	[ 0, 1, 4 ],
	[ 0x4113, 0x2315, 0x3304, 0x1326, 0x4223 ],
	[ 0x1326, 0x4223, 0x4113, 0x2315, 0x6201, 0x5102 ],
	#[ 0x3304, 0x1326, 0x4223, 0x6201 ],
	[ 0, 1, 2, 3 ],
	#[ 0x5102, 0x1326, 0x4223 ],
	[ 0, 1, 4 ],
	#[ 0x5102, 0x4113, 0x2315, 0x3304 ],
	[ 0, 1, 2, 3 ],
	#[ 0x6201, 0x4113, 0x2315 ],
	[ 0, 1, 4 ],
	#[ 0x6201, 0x3304, 0x5102 ],
	[ 0, 1, 4 ],
	[]
]

func get_case_code(buffer : VoxelChunk, x : int, y : int, z : int, size : int = 1) -> int:
	var case_code : int = 0
	
	if (buffer.get_voxel(x, y, z, VoxelChunk.DEFAULT_CHANNEL_TYPE) != 0):
		case_code = case_code | VOXEL_ENTRY_MASK_000
		
	if (buffer.get_voxel(x, y + size, z, VoxelChunk.DEFAULT_CHANNEL_TYPE) != 0):
		case_code = case_code | VOXEL_ENTRY_MASK_010
		
	if (buffer.get_voxel(x, y, z + size, VoxelChunk.DEFAULT_CHANNEL_TYPE) != 0):
		case_code = case_code | VOXEL_ENTRY_MASK_001
		
	if (buffer.get_voxel(x, y + size, z + size, VoxelChunk.DEFAULT_CHANNEL_TYPE) != 0):
		case_code = case_code | VOXEL_ENTRY_MASK_011
		
	if (buffer.get_voxel(x + size, y, z, VoxelChunk.DEFAULT_CHANNEL_TYPE) != 0):
		case_code = case_code | VOXEL_ENTRY_MASK_100
		
	if (buffer.get_voxel(x + size, y + size, z, VoxelChunk.DEFAULT_CHANNEL_TYPE) != 0):
		case_code = case_code | VOXEL_ENTRY_MASK_110
		
	if (buffer.get_voxel(x + size, y, z + size, VoxelChunk.DEFAULT_CHANNEL_TYPE) != 0):
		case_code = case_code | VOXEL_ENTRY_MASK_101
		
	if (buffer.get_voxel(x + size, y + size, z + size, VoxelChunk.DEFAULT_CHANNEL_TYPE) != 0):
		case_code = case_code | VOXEL_ENTRY_MASK_111
		
	return case_code
		
func _add_chunk(buffer : VoxelChunk) -> void:
	var x_size : int = buffer.get_size_x() - 1
	var y_size : int = buffer.get_size_y() - 1
	var z_size : int = buffer.get_size_z() - 1
	
	for y in range(0, y_size, lod_size):
		for z in range(0, z_size, lod_size):
			for x in range(0, x_size, lod_size):
				var case_code : int = get_case_code(buffer, x, y, z, lod_size)
				
				if case_code == 0 or case_code == 255:
					continue
				
				var regular_cell_class : int = get_regular_cell_class(case_code)

				var cell_data : MarchingCubesCellData = get_regular_cell_data(regular_cell_class)

				var index_count : int = cell_data.get_triangle_count() * 3
				var vertex_count : int = cell_data.get_vertex_count()
				
				var uvs : Array = regular_uv_data[case_code]

				for i in range(index_count):
					var ind : int = get_vertex_count() + cell_data.get_vertex_index(i)
					add_indices(ind)
			
				for i in range(vertex_count):
					var fv : int = get_regular_vertex_data_first_vertex(case_code, i)
					var sv : int = get_regular_vertex_data_second_vertex(case_code, i)
					
					var offs0 : Vector3 = corner_id_to_vertex(fv) * lod_size
					var offs1 : Vector3 = corner_id_to_vertex(sv) * lod_size
					
					var type0 : int = buffer.get_voxel(x + offs0.x, y + offs0.y, z + offs0.z, VoxelChunk.DEFAULT_CHANNEL_TYPE)
					var type1 : int = buffer.get_voxel(x + offs1.x, y + offs1.y, z + offs1.z, VoxelChunk.DEFAULT_CHANNEL_TYPE)
					
					var fill : int = 0
					
					var vert_pos : Vector3
					var vert_dir : Vector3
					
					if type0 == 0:
						fill = buffer.get_voxel(x + offs1.x, y + offs1.y, z + offs1.z, VoxelChunk.DEFAULT_CHANNEL_ISOLEVEL)

						vert_pos = get_regular_vertex_second_position(case_code, i)
						vert_dir = get_regular_vertex_first_position(case_code, i)
					else:
						fill = buffer.get_voxel(x + offs0.x, y + offs0.y, z + offs0.z, VoxelChunk.DEFAULT_CHANNEL_ISOLEVEL)
					
						vert_pos = get_regular_vertex_first_position(case_code, i)
						vert_dir = get_regular_vertex_second_position(case_code, i)
					
					vert_dir = vert_dir - vert_pos

					vert_pos += vert_dir * (fill / 256.0)
					vert_pos *= float(lod_size)
					vert_pos += Vector3(x, y, z)
					vert_pos *= float(voxel_scale)
					
					if regular_uv_entries.size() > uvs[i]:
						add_uv(Vector2(regular_uv_entries[uvs[i]][0], regular_uv_entries[uvs[i]][1]));
					
					add_uv(Vector2(0, 0))
					
					add_vertex(vert_pos)
		
	
func create_Debug_triangle(position : Vector3):
	add_indices(get_indices_count())
	add_vertex(position)
	add_indices(get_indices_count())
	add_vertex(position + Vector3(2, 0, 0))
	add_indices(get_indices_count())
	add_vertex(position + Vector3(0, 0, 2))
	
	print(get_vertex_count())
	
	
