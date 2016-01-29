class Cohort < Database::Model
  attr_reader :attributes, :old_attributes

  self.attribute_names =  [:id, :name, :created_at, :updated_at]

    # e.g., Cohort.new(:id => 1, :name => 'Alpha', :created_at => '2012-12-01 05:54:30')
  # def initialize(attributes = {})
  #   super
  #   Cohort.attribute_names.each do |name|
  #     @attributes[name] = attributes[name]
  #   end
  # end

  def students
    Student.where('cohort_id = ?', self[:id])
  end

  def add_students(students)
    students.each do |student|
      student.cohort = self
    end

    students
  end
end
