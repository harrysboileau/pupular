module Pupular
  class Model
    class << self
      attr_reader :attributes

      def _attributes(*attrs)
        attr_accessor(*attrs)
        @attributes = attrs
      end
    end

    def initialize(attrs={})
      set(attrs)
    end

    def set(attrs)
      attrs.each_pair do |attr, value|
        assign(attr, value)
      end
    end

    def assign(attr, value=nil)
      self.send("#{attr}=", value)
    end
  end
end
