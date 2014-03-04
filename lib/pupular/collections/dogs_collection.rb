class Pupular::Dog
  def initialize(attrs);end
end

module Pupular
  module Collections
    class Dogs < Pupular::Collection
      set_model Pupular::Dog
      set_repository :dogs
    end
  end
end
