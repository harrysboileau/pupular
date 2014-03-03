module Pupular
  class Collection
    class << self
      attr_reader :model_class

      def set_model(model_class)
        @model_class = model_class
      end

      def set_repository(repository_type)
        @repository_type = repository_type
      end

      def create(attrs)
        model = @model_class.new(attrs)
        results = save(model)
        results
      end

      def save(model)
        repository.save(model)
      end

      def delete(model)
        repository.delete(model)
      end

      def find(id)
        repository.find(id)
      end

      def update(id, attrs = {})
        model = find(id)
        attrs.each_pair { |attr, value| model.send("#{attr}=", value) }
        save(model)
      end

      def repository
        Pupular::Repository.get(@repository_type)
      end
    end
  end
end
