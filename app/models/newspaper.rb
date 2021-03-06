class Newspaper < ActiveRecord::Base
  def address
    city+""+"ul. "+street+" "+number
  end
  def location
    if(latitude.nil?)
      [50.570684,19.314464]
    else
      [latitude, longitude]
    end
  end
  def has_map?
    ! latitude.nil?
  end
end
