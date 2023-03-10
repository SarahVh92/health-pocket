require "google/cloud/vision"
require 'open-uri'

class OcrScan
  def initialize(pdf_url)
    @pdf_url = pdf_url
    @vision = Google::Cloud::Vision.image_annotator
  end

  def scan
    image = @vision.text_detection(image: URI.open(@pdf_url))
    image.responses[0].text_annotations[0].description.split("\n")
  end
end
