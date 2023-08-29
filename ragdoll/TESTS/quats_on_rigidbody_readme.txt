I ask something similar few days ago and got this reply. First of all, you need to find / calculate the basis value for your final rotation will be

and then you can use this function

func calc_angular_velocity(from_basis: Basis, to_basis: Basis) -> Vector3:
var q1 = from_basis.get_rotation_quat() # need to update to latest quat style for 4.0 documentation e
var q2 = to_basis.get_rotation_quat()

# Quaternion that transforms q1 into q2
var qt = q2 * q1.inverse()

# Angle from quaternion
var angle = 2 * acos(qt.w)

# There are two distinct quaternions for any orientation.
# Ensure we use the representation with the smallest angle.
if angle > PI:
    qt = -qt
    angle = TAU - angle

# Prevent divide by zero
if angle < 0.0001:
    return Vector3.ZERO

# Axis from quaternion
var axis = Vector3(qt.x, qt.y, qt.z) / sqrt(1-qt.w*qt.w)

return axis * angle
from_basis is your rigid body current basis (global_transform.basis). to_basis is the new basis it will ended up having. It will gives you a vector3 that you can use apply_torque_impulse with, or put it into angular_velocity

credit to /u/z80 for making that function