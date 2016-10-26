class Slide < Airmodel::Model

  # default to text if slide has no 'kind' defined
  def slide_type
    if self["Kind"].blank?
      "text"
    else
      self["Kind"].parameterize
    end
  end

  def media_assets
    self['media'].is_a?(Array) ? self['media'].reverse : []
  end

  def media_captions
    self['captions'].is_a?(Array) ? self['captions'].reverse : []
  end

end
