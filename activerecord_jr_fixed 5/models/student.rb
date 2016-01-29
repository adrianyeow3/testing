class Student < Database::Model
 attr_reader :attributes, :old_attributes

  self.attribute_names =  [:id, :cohort_id, :first_name, :last_name, :email,
                           :gender, :birthdate, :created_at, :updated_at]

   # e.g., Student.new(:id => 1, :first_name => 'Steve', :last_name => 'Rogers', ...)

  # We say a record is "new" if it doesn't have a defined primary key in its
  # attributes

  # e.g., student['first_name'] #=> 'Steve'
  def cohort
    Cohort.where('id = ?', self[:cohort_id]).first
  end

  def cohort=(cohort)
    self[:cohort_id] = cohort[:id]
    self.save
    cohort
  end
end
