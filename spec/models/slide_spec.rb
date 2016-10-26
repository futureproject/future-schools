require 'spec_helper'

describe Slide do

  let(:slide) { Slide.new }
  let(:slide_with_bg) {
    Slide.new({'Background' => [{'id' => 'xyz', 'url' => '/image.png' }] })
  }

  describe "slide_type" do
    it "returns 'text' by default" do
      expect(slide.slide_type).to eq "text"
    end
  end

  describe "background_image_url" do
    it "returns nil by default" do
      s = Slide.new
      expect(slide.background_image_url).to eq nil
    end
  end

  describe "media_assets" do
    it "returns an empty array by default" do
      expect(slide.media_assets).to eq []
    end
  end

  describe "media_captions" do
    it "returns an empty array by default" do
      expect(slide.media_captions).to eq []
    end
  end

  describe "background_tag" do
    it "returns nil by default" do
      expect(slide.background_tag).to eq nil
    end
    it "returns CSS when background_image_url works" do
      expect(slide_with_bg.background_tag).to match "image.png"
    end
  end

end
