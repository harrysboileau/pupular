require 'pupular/collections/collection'

describe Pupular::Collection do

  Pupular::Model = Class.new do
    attr_accessor :test
    def initialize(attrs = {});end
    def id; 1;end
  end

  Pupular::Repository       = Class.new
  Pupular::Repository::Fake = Class.new


  let(:model_id)    { 1 }
  let(:model_class) { Class.new(Pupular::Model) }
  let(:collection)  { Class.new(Pupular::Collection) }
  let(:fake_repo)   { Class.new(Pupular::Repository::Fake) }
  let(:repo)        { fake_repo.new }

  before(:each) do
    collection.set_model(model_class)
    allow(Pupular::Repository).to receive(:get) { repo }
  end

  it "belongs to a model" do
    expect(collection.model_class).to be(model_class)
  end

  it "has a repository" do
    allow(Pupular::Repository).to receive(:get) { repo }

    expect(collection.repository).to be_a(fake_repo)
    expect(collection.repository).to equal(repo)
  end

  describe "CRUD" do
    let(:model) { model_class.new(:test => "data") }

    describe "#save" do
      it "saves a model to the repository" do
        repo.should_receive(:save).with(model)
        collection.save(model)
      end
    end

    describe "#create" do
      it "creates a new instance of the model" do
        data = {:test => "data"}
        allow(repo).to receive(:save).and_return(model)
        expect(collection.create(data)).to equal(model)
      end
    end

    describe "#find" do
      it "find the model from it's id" do
        repo.should_receive(:find).with(model.id)
        collection.find(model_id)
      end
    end

    describe "#update" do
      it "finds model, changes attributes, saves change" do
        allow(repo).to receive(:find).with(model_id).and_return(model)
        repo.should_receive(:save).with(model)
        collection.update(model_id, {:test => "updated_data"})
      end
    end

    describe "#delete" do
      it "destroys an model in the repository" do
        repo.should_receive(:delete).with(model)
        collection.delete(model)
      end
    end
  end
end
