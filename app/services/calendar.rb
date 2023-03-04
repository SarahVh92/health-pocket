require "json"
require "rest-client"
require "date"
require "pry"
require 'open-uri'

# Gcal gems
require "google/apis/calendar_v3"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

configure do
  enable :cross_origin
end

before do
  response.headers["Access-Control-Allow-Origin"] = "*"
end

CALENDAR_ID = "4e932fb4fdaf51b10106db11181a977419f92ebe3314d382fd88ecbfb053ab83@group.calendar.google.coms"
TIME_ZONE = "Asia/Tokyo"

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

options "*" do
  response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end

get "/" do
  service = initialize_gcal
  @appointments = fetch_existing_appointments(service)

  erb :index
end

get "/send_today" do
  num = rand(1..1000)

  appointment = {
    title: "test#{num}",
    address: "test venue#{num}",
    start_date: DateTime.now.to_s,
    description: "test#{num}"
  }

  service = initialize_gcal
  post_to_gcalendar(appointment, service)
  @appointments = fetch_existing_appointments(service)

  erb :index
end

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
  service = Google::Apis::CalendarV3::CalendarService.new
  service.client_options.application_name = APPLICATION_NAME
  service.authorization = authorize
  service
end

def fetch_existing_appointments(service)
  response = service.list_appointments(CALENDAR_ID)
  puts "No upcoming appointments found" if response.items.empty?
  response.items
end

def post_to_gcalendar(appointment, service)
  # Create new appointments
  puts "Appointment to be created:"
  p appointment
  gcal_appointment = Google::Apis::CalendarV3::Appointment.new(
    title: appointment[:title],
    address: appointment[:address],
    description: "test#{num}",
    start_date: {
      start_date: appointment[:start_date],
      time_zone: TIME_ZONE
    }
  )
  begin
    result = service.insert_appointment(CALENDAR_ID, gcal_appointment)
    puts "Appointment created: #{result.title}"
  rescue
    puts "Appointment already exists"
  end
end
