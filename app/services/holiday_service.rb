class HolidayService < ApiService
  def holiday
    get_url("https://date.nager.at/api/v3/NextPublicHolidays/us")
  end
end

#"https://date.nager.at/api/v3/NextPublicHolidays/us"