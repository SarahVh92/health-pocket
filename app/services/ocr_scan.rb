require "google/cloud/vision"
class OcrScan
  def initialize(pdf_url)
    @pdf_url = pdf_url
    @vision = Google::Cloud::Vision.image_annotator do |config|
      config.credentials = "http://localhost:3000/lucid-honor-377410-9d5bc28e0192.json"
    end
  end

  def scan
    image = @vision.text_detection(image: URI.open(@pdf_url))
    raise
  end
end
