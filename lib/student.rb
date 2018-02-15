class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # should take in an argument of a hash and use metaprogramming to assign the
    # newly created student attributes and values in accordance with the key/value
    # pairs of the hash. Use the #send method to acheive this.
    # This method should also add the newly created student to the Student class' @@all array of all students.
    student_hash.each do |k,v|
      self.send("#{k}=", v)
    end
    @@all << self
  end


  def self.create_from_collection(students_array)
    # should iterate over the array of hashes and create a new individual student using each hash.
    # This brings us to the #initialize method on our Student class.
    students_array.each do |student_hash|
      Student.new(student_hash)
  end
end

def add_student_attributes(attributes_hash)
 attributes_hash.each do |attr, value|
   self.send("#{attr}=", value)
 end
 self
end

  def self.all
    @@all
  end
end
