class CaptainsController < ApplicationController
  def index
  end

  def create
    if Automation::Captain.new.rise
      puts 'Successfully promoted' 
      redirect_to captains_path, notice: 'Successfully promoted'
    end
  end
end
