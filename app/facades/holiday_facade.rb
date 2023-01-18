class HolidayFacade
  def holiday_api
    holiday_data = HolidayService.new.holiday
    @holidays = holiday_data.map { |holiday| Holiday.new(holiday) }.first(3)
  end
end