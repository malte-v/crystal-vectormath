require "math"

module CrystalEdge
  struct Vec4
    property x, y, z, w

    @x : Float32
    @y : Float32
    @z : Float32
    @w : Float32

    def values
      {@x, @y, @z, @w}
    end

    def initialize(@x, @y, @z, @w : Float32)
    end

    # Shorter constructor
    def self.[](x, y, z, w : Number)
      return Vec4.new(x.to_f32, y.to_f32, z.to_f32, w.to_f32)
    end

    # Zero vector
    def self.zero
      return Vec4.new(0.0_f32, 0.0_f32, 0.0_f32, 0.0_f32)
    end

    def zero!
      @x = @y = @z = @w = 0.0_f32
    end

    # Dot product
    def dot(other : Vec4)
      x*other.x + y*other.y + z*other.z
    end

    # Cross product
    def cross(other : Vec4)
      Vec4.new(
        self.y*other.z - self.z*other.y,
        self.z*other.x - self.x*other.z,
        self.x*other.y - self.y*other.x,
        0
      )
    end

    def **(other : Vec4)
      dot other
    end

    def %(other : Vec4)
      cross other
    end

    def magnitude
      Math.sqrt(self.x**2 + self.y**2 + self.z**2 + self.w**2)
    end

    def +(other : Vec4)
      Vec4.new(self.x + other.x, self.y + other.y, self.z + other.z, self.w + other.w)
    end

    def +(other : Float32)
      Vec4.new(self.x + other, self.y + other, self.z + other, self.w + other)
    end

    def -(other : Vec4)
      Vec4.new(self.x - other.x, self.y - other.y, self.z - other.z, self.w - other.w)
    end

    def -(other : Float32)
      Vec4.new(self.x - other, self.y - other, self.z - other, self.w - other)
    end

    def -
      Vec4.new(-self.x, -self.y, -self.z, -self.w)
    end

    def *(other : Vec4)
      Vec4.new(self.x*other.x, self.y*other.y, self.z*other.z, self.w*other.w)
    end

    def *(other : Float32)
      Vec4.new(self.x*other, self.y * other, self.z * other, self.w * other)
    end

    def /(other : Vec4)
      Vec4.new(self.x/other.x, self.y/other.y, self.z/other.z, self.w/other.w)
    end

    def /(other : Float32)
      # Multiply by the inverse => only do 1 division instead of 3
      self * (1.0_f32 / other)
    end

    def clone
      Vec4.new(self.x, self.y, self.z, self.w)
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
        self.w *= inverse
      end
      self
    end

    def normalize
      clone.normalize!
    end

    def distance(other : Vec4)
      return (self - other).magnitude
    end

    def ==(other : Vec4)
      self.x == other.x && self.y == other.y && self.z == other.z && self.w == other.w # TODO : Comparsion with EPSILON
    end

    def !=(other : Vec4)
      self.x != other.x || self.y != other.y || self.z != other.z || self.w != other.w # TODO : Comparsion with EPSILON
    end

    def to_s
      "{X : #{x}; Y : #{y}, Z : #{z}, W: : #{w}}"
    end
  end

  struct DVec4
    property x, y, z, w

    @x : Float64
    @y : Float64
    @z : Float64
    @w : Float64

    def values
      {@x, @y, @z, @w}
    end

    def initialize(@x, @y, @z, @w : Float64)
    end

    # Shorter constructor
    def self.[](x, y, z, w : Number)
      return DVec4.new(x.to_f64, y.to_f64, z.to_f64, w.to_f64)
    end

    # Zero vector
    def self.zero
      return DVec4.new(0.0, 0.0, 0.0, 0.0)
    end

    def zero!
      @x = @y = @z = @w = 0.0
    end

    # Dot product
    def dot(other : DVec4)
      x*other.x + y*other.y + z*other.z
    end

    # Cross product
    def cross(other : DVec4)
      DVec4.new(
        self.y*other.z - self.z*other.y,
        self.z*other.x - self.x*other.z,
        self.x*other.y - self.y*other.x,
        0
      )
    end

    def **(other : DVec4)
      dot other
    end

    def %(other : DVec4)
      cross other
    end

    def magnitude
      Math.sqrt(self.x**2 + self.y**2 + self.z**2 + self.w**2)
    end

    def +(other : DVec4)
      DVec4.new(self.x + other.x, self.y + other.y, self.z + other.z, self.w + other.w)
    end

    def +(other : Float64)
      DVec4.new(self.x + other, self.y + other, self.z + other, self.w + other)
    end

    def -(other : DVec4)
      DVec4.new(self.x - other.x, self.y - other.y, self.z - other.z, self.w - other.w)
    end

    def -(other : Float64)
      DVec4.new(self.x - other, self.y - other, self.z - other, self.w - other)
    end

    def -
      DVec4.new(-self.x, -self.y, -self.z, -self.w)
    end

    def *(other : DVec4)
      DVec4.new(self.x*other.x, self.y*other.y, self.z*other.z, self.w*other.w)
    end

    def *(other : Float64)
      DVec4.new(self.x*other, self.y * other, self.z * other, self.w * other)
    end

    def /(other : DVec4)
      DVec4.new(self.x/other.x, self.y/other.y, self.z/other.z, self.w/other.w)
    end

    def /(other : Float64)
      # Multiply by the inverse => only do 1 division instead of 3
      self * (1.0 / other)
    end

    def clone
      DVec4.new(self.x, self.y, self.z, self.w)
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
        self.w *= inverse
      end
      self
    end

    def normalize
      clone.normalize!
    end

    def distance(other : DVec4)
      return (self - other).magnitude
    end

    def ==(other : DVec4)
      self.x == other.x && self.y == other.y && self.z == other.z && self.w == other.w # TODO : Comparsion with EPSILON
    end

    def !=(other : DVec4)
      self.x != other.x || self.y != other.y || self.z != other.z || self.w != other.w # TODO : Comparsion with EPSILON
    end

    def to_s
      "{X : #{x}; Y : #{y}, Z : #{z}, W: : #{w}}"
    end
  end
end
