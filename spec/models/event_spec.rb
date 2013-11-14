require 'spec_helper'

describe Event do

  context 'associations' do
    it { should belong_to(:creator) }
    it { should have_many(:event_attendances) }
    it { should have_many(:attendees) }
  end

  context 'validations' do
    it { should validate_presence_of(:creator_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:type) }
    it { should ensure_inclusion_of(:type).in_array(["Walk", "Hangout"]) }

    it "will belong to the Hangout class if passed to type 'Hangout'" do
      dog = create(:dog)
      hangout = Event.create(attributes_for(:event, type: "Hangout"))
      hangout.creator_id = dog.id
      hangout.save
      expect(Event.find(hangout.id)).to be_a(Hangout)
    end

    it "will belong to the Walk class if passed to type 'Walk'" do
      dog = create(:dog)
      walk = Event.create(attributes_for(:event, type: "Walk"))
      walk.creator_id = dog.id
      walk.save
      expect(Event.find(walk.id)).to be_a(Walk)
    end

    it "will display AM if time is before noon" do
      event = Event.create(attributes_for(:event, start_time: "2013-11-14 09:00:00 -0600"))
      expect(event.time).to match(/AM/)
    end

    it "will display PM if time is after noon" do
      event = Event.create(attributes_for(:event, start_time: "2013-11-14 21:00:00 -0600"))
      expect(event.time).to match(/PM/)
    end
  end
end
