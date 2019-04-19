require "math"

module CrystalEdge
  # Representation of 2D vector
  struct Vec2
    property x, y
    @x : Float32
    @y : Float32

    # Converts vector to a tuple of values
    def values
      {@x, @y}
    end

    # Initializes vector with `x` and `y`
    def initialize(@x, @y)
    end

    # Shorter constructor
    def self.[](x, y : Number)
      return Vec2.new(x.to_f32, y.to_f32)
    end

    # Zero vector
    def self.zero
      return Vec2.new(0.0_f32, 0.0_f32)
    end

    # Fills current vector with zero
    def zero!
      @x = @y = 0.0_f32
      self
    end

    # Returns dot product of two vectors
    def dot(other : Vec2)
      x*other.x + y*other.y
    end

    # Returns cross product of two vectors
    def cross(other : Vec2)
      Vec2.new(self.x*other.y - self.y*other.x, self.y*other.x - self.x*other.y)
    end

    # Alias for dot product
    def **(other : Vec2)
      dot other
    end

    # Alias for cross product
    def %(other : Vec2)
      cross other
    end

    # Returns magnitude of this vector
    def magnitude
      Math.sqrt(self.x**2 + self.y**2)
    end

    # Returns angle between two vectors
    def angle(other : Vec2)
      self**other / (self.magnitude * other.magnitude)
    end

    # Returns direction of a vector
    def angle
      Math.atan2(self.y, self.x)
    end

    # ditto
    def heading
      angle
    end

    # Performs component addition
    def +(other : Vec2)
      Vec2.new(self.x + other.x, self.y + other.y)
    end

    # Performs component addition
    def +(other : Float32)
      Vec2.new(self.x + other, self.y + other)
    end

    # Performs component subtraction
    def -(other : Vec2)
      Vec2.new(self.x - other.x, self.y - other.y)
    end

    # Performs component subtraction
    def -(other : Float32)
      Vec2.new(self.x - other, self.y - other)
    end

    # Returns negated vector
    def -
      Vec2.new(-self.x, -self.y)
    end

    # Performs component multiplication (for dot product see `#dot`)
    def *(other : Vec2)
      Vec2.new(self.x*other.x, self.y*other.y)
    end

    # Performs multiplication
    def *(other : Float32)
      Vec2.new(self.x*other, self.y * other)
    end

    # Performs component division
    def /(other : Vec2)
      Vec2.new(self.x/other.x, self.y/other.y)
    end

    # Performs division
    def /(other : Float32)
      # Multiply by the inverse => only do 1 division instead of 3
      self * (1.0_f32 / other)
    end

    # Clones this vector and passes it into a block if given
    def clone
      Vec2.new(self.x, self.y)
    end

    # ditto
    def clone(&b)
      c = clone
      b.call c
      c
    end

    # Normalizes current vector
    def normalize!
      m = magnitude
      unless m == 0
        inverse = 1.0_f32 / m
        self.x *= inverse
        self.y *= inverse
      end
      self
    end

    # Non-aggressive version of `#normalize!`
    def normalize
      clone.normalize!
    end

    # Finds normal axis between two vectors
    def find_normal_axis(other : Vec2)
      (self % other).normalize
    end

    # Finds distance between two vectors
    def distance(other : Vec2)
      return (self - other).magnitude
    end

    def ==(other : Vec2)
      self.x == other.x && self.y == other.y
    end

    def !=(other : Vec2)
      self.x != other.x || self.y != other.y
    end

    # Formats vector
    def to_s
      "{X : #{x}; Y : #{y}}"
    end
  end

  struct DVec2
    property x, y
    @x : Float64
    @y : Float64

    # Converts vector to a tuple of values
    def values
      {@x, @y}
    end

    # Initializes vector with `x` and `y`
    def initialize(@x, @y)
    end

    # Shorter constructor
    def self.[](x, y : Number)
      return DVec2.new(x.to_f64, y.to_f64)
    end

    # Zero vector
    def self.zero
      return DVec2.new(0.0, 0.0)
    end

    # Fills current vector with zero
    def zero!
      @x = @y = 0.0
      self
    end

    # Returns dot product of two vectors
    def dot(other : DVec2)
      x*other.x + y*other.y
    end

    # Returns cross product of two vectors
    def cross(other : DVec2)
      DVec2.new(self.x*other.y - self.y*other.x, self.y*other.x - self.x*other.y)
    end

    # Alias for dot product
    def **(other : DVec2)
      dot other
    end

    # Alias for cross product
    def %(other : DVec2)
      cross other
    end

    # Returns magnitude of this vector
    def magnitude
      Math.sqrt(self.x**2 + self.y**2)
    end

    # Returns angle between two vectors
    def angle(other : DVec2)
      self**other / (self.magnitude * other.magnitude)
    end

    # Returns direction of a vector
    def angle
      Math.atan2(self.y, self.x)
    end

    # ditto
    def heading
      angle
    end

    # Performs component addition
    def +(other : DVec2)
      DVec2.new(self.x + other.x, self.y + other.y)
    end

    # Performs component addition
    def +(other : Float64)
      DVec2.new(self.x + other, self.y + other)
    end

    # Performs component subtraction
    def -(other : DVec2)
      DVec2.new(self.x - other.x, self.y - other.y)
    end

    # Performs component subtraction
    def -(other : Float64)
      DVec2.new(self.x - other, self.y - other)
    end

    # Returns negated vector
    def -
      DVec2.new(-self.x, -self.y)
    end

    # Performs component multiplication (for dot product see `#dot`)
    def *(other : DVec2)
      DVec2.new(self.x*other.x, self.y*other.y)
    end

    # Performs multiplication
    def *(other : Float64)
      DVec2.new(self.x*other, self.y * other)
    end

    # Performs component division
    def /(other : DVec2)
      DVec2.new(self.x/other.x, self.y/other.y)
    end

    # Performs division
    def /(other : Float64)
      # Multiply by the inverse => only do 1 division instead of 3
      self * (1.0 / other)
    end

    # Clones this vector and passes it into a block if given
    def clone
      DVec2.new(self.x, self.y)
    end

    # ditto
    def clone(&b)
      c = clone
      b.call c
      c
    end

    # Normalizes current vector
    def normalize!
      m = magnitude
      unless m == 0
        inverse = 1.0 / m
        self.x *= inverse
        self.y *= inverse
      end
      self
    end

    # Non-aggressive version of `#normalize!`
    def normalize
      clone.normalize!
    end

    # Finds normal axis between two vectors
    def find_normal_axis(other : DVec2)
      (self % other).normalize
    end

    # Finds distance between two vectors
    def distance(other : DVec2)
      return (self - other).magnitude
    end

    def ==(other : DVec2)
      self.x == other.x && self.y == other.y
    end

    def !=(other : DVec2)
      self.x != other.x || self.y != other.y
    end

    # Formats vector
    def to_s
      "{X : #{x}; Y : #{y}}"
    end
  end
end
