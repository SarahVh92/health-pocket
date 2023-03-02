require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require 'open-uri'

  class Calendar
    def initialize

      @service = Google::Apis::CalendarV3::CalendarService.new

      @service.client_options.application_name = APPLICATION_NAME

      @service.authorization = authorize

      @calendar_id = MY_CALENDAR_IDs
    end
end
