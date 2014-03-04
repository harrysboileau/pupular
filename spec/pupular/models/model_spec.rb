require 'pupular/models/model'

describe Pupular::Model do
  let(:model_class) { Class.new(Pupular::Model) }
  let(:fake_model) { model_class.new({:name => "Fido"}) }

  before { model_class._attributes :name }

  it "assigns attributes" do
    expect(model_class.attributes).to include(:name)
  end

  it "sets attributes" do
    expect(fake_model.name).to eql("Fido")
  end

end
