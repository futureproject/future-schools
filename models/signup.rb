class Signup < Airmodel::Model
  def required_fields
    ["Name", "Email"]
  end

  def valid?
    !required_fields.find{|x| self[x].blank? }
  end

  def errors
    if valid?
      nil
    else
      "#{required_fields.join(', ')} are all required."
    end
  end

end
