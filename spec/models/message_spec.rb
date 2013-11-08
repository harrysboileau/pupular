require 'spec_helper'

describe Message do
  context 'associations' do
    it { should belong_to(:sender) }
    it { should have_many(:inbox_messages) }
    it { should have_many(:recipients) }
  end
  context 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:sender_id) }
    it { should validate_presence_of(:type) }
    it { should ensure_inclusion_of(:type).in_array(["Automated", "Personal"]) }
  end
end
