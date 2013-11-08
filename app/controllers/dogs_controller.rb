class DogsController < ApplicationController

  def new
    @dog = Dog.new
  end

  def savehuman
    redirect_to name_path
  end

  def name
    @dog = Dog.new
  end

  def create
    # Save row in dogs table
    redirect_to new_profile_path
  end

  def doghouse
  end

  def show
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
