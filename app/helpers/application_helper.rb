module ApplicationHelper

  def current_dog
    Dog.find(1)
  end
end
