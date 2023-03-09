require "json"
require "rest-client"
require "date"
require 'open-uri'

# Gcal gems
require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

class Gcal
  def initialize
    @service = initialize_gcal
  end

  CALENDAR_ID = "4e932fb4fdaf51b10106db11181a977419f92ebe3314d382fd88ecbfb053ab83@group.calendar.google.com"
  # TIME_ZONE = "Asia/Tokyo"

  # Gcal API post
  OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
  APPLICATION_NAME = "HealthPocket".freeze
  CREDENTIALS_PATH = "oauth_key.json".freeze
  # The file token.yaml stores the user's access and refresh tokens, and is
  # created automatically when the authorization flow completes for the first
  # time.
  TOKEN_PATH = "token.yaml".freeze
  SCOPE = "https://www.googleapis.com/auth/calendar"
  ##
  # Ensure valid credentials, either by restoring from the saved credentials
  # files or intitiating an OAuth2 authorization. If authorization is required,
  # the user's default browser will be launched to approve the request.
  #
  # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials



  def fetch_existing_appointments(service)
    response = @service.list_appointments(CALENDAR_ID)
    puts "No upcoming appointments found" if response.items.empty?
    response.items
  end

  def post_to_gcalendar(appointment, service)
    # Create new appointments
    # Example to know what  it looks like
    # appointment = {
    #   title: "Dentist",
    #   address: "Harajuku: 'Happy Mouth",
    #   date: DateTime.now.to_s,
    #   description: "Wisdom tooth extraction"
    # }
    puts "Appointment to be created:"
    p appointment
    # gcal_appointment = Google::Apis::CalendarV3::Event.new(
    #   title: appointment[:title],
    #   description: appointment[:description],
    #   date: appointment[:date],
    #   address: appointment[:address]
    # )
    num = rand(0...100)
    event = {
      id: rand.to_s[2..11],
      group: "test group#{num}",
      name: "test#{num}",
      venue: "test venue#{num}",
      date: DateTime.now.to_s,
      url: "www",
      description: "test description"
    }
    gcal_appointment = Google::Apis::CalendarV3::Event.new(
      summary: appointment[:title],
      location: appointment[:address],
      description: appointment[:description],
      # html_link: event[:url],
      start: {
        date_time: appointment[:date].to_datetime.to_s # should be like 2020-03-25T17:04:00-07:00
      },
      end: {
        date_time: appointment[:date].to_datetime.to_s
      }
    )
    result = @service.insert_event(CALENDAR_ID, gcal_appointment)
    puts "Appointment created: #{result}"
    # begin
    # rescue
    #   puts "Appointment already exists"
    # end
  end

  private

  def authorize
    client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "default"
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url base_url: OOB_URI
      puts "Open the following URL in the browser and enter the " \
          'resulting code after authorization:\n' + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def initialize_gcal
    # Initialize the API
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
    @service
  end
end
