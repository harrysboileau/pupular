module EventHelper
  def format_date(date_string)
    Date.strptime(date_string, '%m/%d/%Y')
  end
end