class Student

  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  def initialize(name, grade)
    @id = nil
    @name = name
    @grade = grade
  end

  def self.create_table
    DB[:conn].execute(
      "CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )"
    )
  end

  def self.drop_table
    DB[:conn].execute(
      "DROP TABLE students"
    )
  end

  def save
    DB[:conn].execute(
      "INSERT INTO students (name, grade) VALUES ( ?, ? )", [self.name, self.grade]
    )
    @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1")[0][0]
  end

  def self.create(hash)
    student = Student.new(hash[:name], hash[:grade])
    student.save
    student
  end
  
end
