require 'spec_helper'

describe Profile do

  context "associations" do
      it { should belong_to(:dog)}
  end

  context "validations" do
    it { should validate_presence_of(:age)}
    it { should validate_presence_of(:breed)}
    it { should validate_presence_of(:dog_id)}
    it { should validate_presence_of(:gender)}
    it { should ensure_inclusion_of(:gender).in_array(["male","female"]) }
    it { should validate_presence_of(:location)}
    it { should validate_presence_of(:photo)}
    it { should validate_presence_of(:spayed)}
    it { should validate_presence_of(:size)}
    it { should ensure_inclusion_of(:size).in_array(["toy", "small", "medium", "large", "extra-large"]) }
  end
end
