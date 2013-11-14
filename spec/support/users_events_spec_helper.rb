module UsersEventsSpecHelper
  def go_to_doghouse_with_event
    sign_up
    pal = create(:dog)
    Dog.find_by_name("tester").attended_events << create(:event, creator_id: pal.id)
    find("#btm_br_home").click
  end
end
