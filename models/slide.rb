class Slide < Airmodel::Model

  def slide_type
    if self["Kind"].blank?
      "text"
    else
      self["Kind"].parameterize
    end
  end
end
