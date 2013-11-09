class DogsController < ApplicationController

  def new
    @dog = Dog.new
  end

  def savehuman
    @dog = Dog.new(params[:dog])
    if @dog.save && DogSession.create(params[:dog])
      redirect_to name_path
    else
      render "new"
    end
  end

  def name
    if current_dog
      @dog = current_dog
    else
      @dog = Dog.new(email: "Something went wrong")
    end
  end

  def create
    @dog = current_dog

    if @dog.update_attributes(params[:dog])
      redirect_to new_profile_path
    else
      render "name"
    end
  end

  def doghouse
    @dog = Dog.find(1)
    @events = @dog.events
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def search
    @dogs = Dog.all
  end

  def filter_search
    p params
    @search_term = params[:search][:search_term]
    @dogs = Dog.where('name LIKE ?', "%#{@search_term}%").all

  end

  def add_friend
  end

end
