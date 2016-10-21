class Page < Airmodel::Model

  def ordered_sections
    Section.find(self.sections.reverse)
  end

end
