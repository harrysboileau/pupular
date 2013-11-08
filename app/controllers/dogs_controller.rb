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
  end

  def filter_search
  end

  def add_friend
  end

end
