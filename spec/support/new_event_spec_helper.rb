module NewEventSpecHelper
  def go_to_new_event
    sign_up
    page.find("a#btm_br_evt").click
  end

  def fill_out_event
    event = attributes_for(:event)
    fill_in "event_title", with: event[:title]
    fill_in "event_location", with: event[:location]
    fill_in "event_date", with: "12/20/2013"
    fill_in "event_description", with: event[:description]
  end

  def add_pal
    pal = create(:dog)
    Dog.find_by_name("tester").pals << pal
    pal
  end

  def create_hangout_event
    click_button "Hangout"
    click_button "Hangout"
    fill_out_event
    submit
  end

  def create_walk_event
    click_button "Walk"
    click_button "Walk"
    fill_out_event
    submit
  end

  def add_pal_to_event(pal)
    fill_in "event_friends_search_input", with: pal.name
    find("#event_friends_search_button").click
    click_button "Invite Pals"
  end
end


