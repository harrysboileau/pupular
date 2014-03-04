require 'pupular/collections/collection'

describe Pupular::Collection do
  Pupular::Repository       = Class.new
  Pupular::Repository::Fake = Class.new

  let(:model_class) { Class.new(Pupular::Model) }
  let(:collection)  { Class.new(Pupular::Collection) }
  let(:repo_class)  { Class.new(Pupular::Repository::Fake) }
  let(:fake_repo)   { repo_class.new }

  before { model_class._attributes :test }

  before(:each) do
    collection.set_model(model_class)
    allow(Pupular::Repository).to receive(:get) { fake_repo }
  end

  it "belongs to a model" do
    expect(collection.model_class).to be(model_class)
  end

  it "has a repository" do
    allow(Pupular::Repository).to receive(:get) { fake_repo }

    expect(collection.repository).to be_a(repo_class)
    expect(collection.repository).to equal(fake_repo)
  end

  describe "CRUD" do
    let(:model) { model_class.new(:test => "data") }

    describe "#save" do
      it "saves a model to the repository" do
        fake_repo.should_receive(:save).with(model)
        collection.save(model)
      end
    end

    describe "#create" do
      it "creates a new instance of the model" do
        data = {:test => "data"}
        allow(fake_repo).to receive(:save).and_return(model)
        expect(collection.create(data)).to equal(model)
      end
    end

    describe "#find" do
      it "find the model from it's id" do
        allow(model).to receive(:id).and_return(1)
        fake_repo.should_receive(:find).with(model.id)
        collection.find(1)
      end
    end

    describe "#update" do
      it "finds model, changes attributes, saves change" do
        allow(fake_repo).to receive(:find).with(1).and_return(model)
        fake_repo.should_receive(:save).with(model)
        collection.update(1, {:test => "updated_data"})
      end
    end

    describe "#delete" do
      it "destroys an model in the repository" do
        fake_repo.should_receive(:delete).with(model)
        collection.delete(model)
      end
    end
  end
end
