require "google/cloud/translate/v2"
require 'open-uri'

class CloudTranslation
  def initialize(pdf_url)
    @pdf_url = pdf_url
    translate = Google::Cloud::Translate::V2.new
    @lang = params["lang"] || "la"
  end

  def translation
    translation = @translate.translate "Hello world!", to: "la"
    translated = translation.text #=> "Salve mundi!"
  end
end
