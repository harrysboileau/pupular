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
    @search_term = params[:search][:search_term]
    @dogs = Dog.where('name LIKE ?', "%#{@search_term}%").all

  end

  def add_friend
    current_dog.accept_pal(params[:pending_pal_id])
    redirect_to doghouse_path(current_dog)
  end

  def reject_friend
    current_dog.deny_pal(params[:pending_pal_id])
    redirect_to doghouse_path(current_dog)
  end

  def friend_request
    Dog.find(params[:pending_pal_id]).pending_pals << current_dog
    binding.pry
    redirect_to search_path
  end
end
