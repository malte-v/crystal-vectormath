require "math"
require "../crystaledge"

module CrystalEdge
  struct Vec3
    property x, y, z

    @x : Float32
    @y : Float32
    @z : Float32

    def values
      {@x, @y, @z}
    end

    def initialize(@x, @y, @z : Float32)
    end

    # Shorter constructor
    def self.[](x, y, z : Number)
      return Vec3.new(x.to_f32, y.to_f32, z.to_f32)
    end

    def initialize(angle : Vec3, length : Float32 = 1.0_f32)
      vec = Vec3.new(
        Math.tan(angle.y),
        1.0_f32 / Math.tan(angle.x),
        1.0_f32
      ).normalize * length

      # vec = Vec3.new(
      #  Math.sin(angle.y),
      #  Math.sin(angle.z),
      #  Math.sin(angle.x)
      # ).normalize * length
      @x, @y, @z = vec.x, vec.y, vec.z
    end

    # Zero vector
    def self.zero
      Vec3.new(0.0_f32, 0.0_f32, 0.0_f32)
    end

    def zero!
      @x = @y = @z = 0.0_f32
    end

    # Dot product
    def dot(other : Vec3)
      x*other.x + y*other.y + z*other.z
    end

    # Cross product
    def cross(other : Vec3)
      Vec3.new(
        y*other.z - z*other.y,
        z*other.x - x*other.z,
        x*other.y - y*other.x
      )
    end

    def **(other : Vec3)
      dot other
    end

    def %(other : Vec3)
      cross other
    end

    def magnitude
      Math.sqrt(self.x**2 + self.y**2 + self.z**2)
    end

    def angle(other : Vec3)
      2.0_f32 * Math.acos(self**other / (self.magnitude * other.magnitude))
    end

    def +(other : Vec3)
      Vec3.new(self.x + other.x, self.y + other.y, self.z + other.z)
    end

    def +(other : Float32)
      Vec3.new(self.x + other, self.y + other, self.z + other)
    end

    def -(other : Vec3)
      Vec3.new(self.x - other.x, self.y - other.y, self.z - other.z)
    end

    def -(other : Float32)
      Vec3.new(self.x - other, self.y - other, self.z - other)
    end

    def -
      Vec3.new(-self.x, -self.y, -self.z)
    end

    def *(other : Vec3)
      Vec3.new(self.x*other.x, self.y*other.y, self.z*other.z)
    end

    def *(other : Float32)
      Vec3.new(self.x*other, self.y * other, self.z*other)
    end

    def /(other : Vec3)
      Vec3.new(self.x/other.x, self.y/other.y, self.z/other.z)
    end

    def /(other : Float32)
      # Multiply by the inverse => only do 1 division instead of 3
      self * (1.0_f32 / other)
    end

    def clone
      Vec3.new(self.x, self.y, self.z)
    end

    def clone(&b)
      c = clone
      b.call c
      c
    end

    def normalize!
      m = magnitude
      unless m == 0
        inverse = 1.0_f32 / m
        self.x *= inverse
        self.y *= inverse
        self.z *= inverse
      end
      self
    end

    def normalize
      clone.normalize!
    end

    def find_normal_axis(other : Vec3)
      (self % other).normalize
    end

    def distance(other : Vec3)
      return (self - other).magnitude
    end

    def ==(other : self)
      (self.x - other.x).abs <= EPSILON &&
        (self.y - other.y).abs <= EPSILON &&
        (self.z - other.z).abs <= EPSILON
    end

    def !=(other : Vec3)
      !(self == other)
    end

    def to_s
      "{X : #{x}; Y : #{y}; Z : #{z}}"
    end

    def rotate(q : Quaternion)
      quat = q * self * q.conjugate
      Vec3.new(quat.x, quat.y, quat.z)
    end

    def angle
      Vec3.new(
        Math.atan2(self.z, self.y),
        Math.atan2(self.x, self.z),
        Math.atan2(self.y, self.x)
      )
    end

    def heading
      angle
    end

    def rotate(euler : Vec3)
      Vec3.new(angle + euler, magnitude)
    end
  end

  struct DVec3
    property x, y, z

    @x : Float64
    @y : Float64
    @z : Float64

    def values
      {@x, @y, @z}
    end

    def initialize(@x, @y, @z : Float64)
    end

    # Shorter constructor
    def self.[](x, y, z : Number)
      return DVec3.new(x.to_f64, y.to_f64, z.to_f64)
    end

    def initialize(angle : DVec3, length : Float64 = 1.0)
      vec = DVec3.new(
        Math.tan(angle.y),
        1.0 / Math.tan(angle.x),
        1.0
      ).normalize * length

      # vec = DVec3.new(
      #  Math.sin(angle.y),
      #  Math.sin(angle.z),
      #  Math.sin(angle.x)
      # ).normalize * length
      @x, @y, @z = vec.x, vec.y, vec.z
    end

    # Zero vector
    def self.zero
      DVec3.new(0.0, 0.0, 0.0)
    end

    def zero!
      @x = @y = @z = 0.0
    end

    # Dot product
    def dot(other : DVec3)
      x*other.x + y*other.y + z*other.z
    end

    # Cross product
    def cross(other : DVec3)
      DVec3.new(
        y*other.z - z*other.y,
        z*other.x - x*other.z,
        x*other.y - y*other.x
      )
    end

    def **(other : DVec3)
      dot other
    end

    def %(other : DVec3)
      cross other
    end

    def magnitude
      Math.sqrt(self.x**2 + self.y**2 + self.z**2)
    end

    def angle(other : DVec3)
      2.0 * Math.acos(self**other / (self.magnitude * other.magnitude))
    end

    def +(other : DVec3)
      DVec3.new(self.x + other.x, self.y + other.y, self.z + other.z)
    end

    def +(other : Float64)
      DVec3.new(self.x + other, self.y + other, self.z + other)
    end

    def -(other : DVec3)
      DVec3.new(self.x - other.x, self.y - other.y, self.z - other.z)
    end

    def -(other : Float64)
      DVec3.new(self.x - other, self.y - other, self.z - other)
    end

    def -
      DVec3.new(-self.x, -self.y, -self.z)
    end

    def *(other : DVec3)
      DVec3.new(self.x*other.x, self.y*other.y, self.z*other.z)
    end

    def *(other : Float64)
      DVec3.new(self.x*other, self.y * other, self.z*other)
    end

    def /(other : DVec3)
      DVec3.new(self.x/other.x, self.y/other.y, self.z/other.z)
    end

    def /(other : Float64)
      # Multiply by the inverse => only do 1 division instead of 3
      self * (1.0 / other)
    end

    def clone
      DVec3.new(self.x, self.y, self.z)
    end

    def clone(&b)
      c = clone
      b.call c
      c
    end

    def normalize!
      m = magnitude
      unless m == 0
        inverse = 1.0 / m
        self.x *= inverse
        self.y *= inverse
        self.z *= inverse
      end
      self
    end

    def normalize
      clone.normalize!
    end

    def find_normal_axis(other : DVec3)
      (self % other).normalize
    end

    def distance(other : DVec3)
      return (self - other).magnitude
    end

    def ==(other : self)
      (self.x - other.x).abs <= EPSILON &&
        (self.y - other.y).abs <= EPSILON &&
        (self.z - other.z).abs <= EPSILON
    end

    def !=(other : DVec3)
      !(self == other)
    end

    def to_s
      "{X : #{x}; Y : #{y}; Z : #{z}}"
    end

    def rotate(q : Quaternion)
      quat = q * self * q.conjugate
      DVec3.new(quat.x, quat.y, quat.z)
    end

    def angle
      DVec3.new(
        Math.atan2(self.z, self.y),
        Math.atan2(self.x, self.z),
        Math.atan2(self.y, self.x)
      )
    end

    def heading
      angle
    end

    def rotate(euler : DVec3)
      DVec3.new(angle + euler, magnitude)
    end
  end
end
