class Slide < Airmodel::Model

  # default to text if slide has no 'kind' defined
  def slide_type
    if self["Kind"].blank?
      "text"
    else
      self["Kind"].parameterize
    end
  end

  # list Assets in display order
  def media_assets
    self['media'].is_a?(Array) ? self['media'].reverse : []
  end

  # list asset captions in display order
  def media_captions
    self['captions'].is_a?(Array) ? self['captions'].reverse : []
  end

  # if this slide has a background image,
  # output its url
  def background_image_url
    if self['Background'].is_a?(Array) && self['Background'].count > 0
      self['Background'].first['url']
    else
      nil
    end
  end

  # output raw CSS background image if applicable
  def background_tag
    if background_image_url
      "background-image: url(#{background_image_url});"
    else
      nil
    end
  end

end
