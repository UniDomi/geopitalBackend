require 'oj'
module ApiHelper

  def create_json
    max_year = HospitalAttribute.maximum("year")
    hospitals = Hospital.includes(:hospital_attributes).where(:hospital_attributes => {:year => max_year}).as_json(:except => [:created_at, :updated_at], :include => [:hospital_attributes => {:except => [:id, :hospital_id, :created_at, :updated_at]}])
    return Oj.dump(hospitals)
  end

end
