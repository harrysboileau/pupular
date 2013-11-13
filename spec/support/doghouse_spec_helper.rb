module DoghouseSpecHelper
  def sign_up
    guest_sign_up(attributes_for(:dog, name: "tester"))
    click_link "skip"
  end

  def open_search_bar
    sign_up
    page.find("a#top_br_sch").click
  end
end
