require 'pupular/collections/dogs_collection'

class Pupular::Repositories;end
class Pupular::Repositories::Dogs
  def self.save(_)Pupular::Dog.new(_);end
end

class Pupular::Repository
  def self.get(name);Pupular::Repositories::Dogs;end
end

describe Pupular::Collections::Dogs do
  subject { described_class }
  it "has Pupular::Dog as the model" do
    dog = subject.create(:name => "Fido")
    dog.should be_a Pupular::Dog
  end
end
