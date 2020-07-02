class CreatesProject
  attr_accessor :name, :project

  def initilize(name: "")
    @name = name
  end

  def build
    self.project = Project.new(name: name)
  end
end
