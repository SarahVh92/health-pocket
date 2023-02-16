require "google/cloud/translate/v2"
require 'open-uri'

class Translation
  def initialize
    @translate = Google::Cloud::Translate::V2.new
  end

  def translate(lang, text)
    translation = @translate.translate "text", to: lang
    translated = translation.text
  end
end
