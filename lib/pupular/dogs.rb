module Pupular
  module Dogs
    def self.new
      DogService.new
    end

    class DogService
      def initialize
        self.collection = Pupular::Collection::Dogs
      end
    end

  end
end
