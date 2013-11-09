require 'spec_helper'

describe Profile do

  context "associations" do
      it { should belong_to(:dog)}
  end

  context "validations" do
    it { should ensure_inclusion_of(:gender).in_array(["", "Male","Female"]) }
    it { should ensure_inclusion_of(:size).in_array(["", "Toy", "Small", "Medium", "Large", "Extra-large"]) }
  end
end
