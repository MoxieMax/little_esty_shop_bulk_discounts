class Holiday
  attr_reader :name,
              :date
  
  def initialize(data)
    @name = data[:localName]
    @date = data[:date]
  end
end
# 
# 9: Holidays API
# 
# As a merchant
# When I visit the discounts index page
# I see a section with a header of "Upcoming Holidays"
# In this section the name and date of the next 3 upcoming US holidays are listed.
# 
# Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)