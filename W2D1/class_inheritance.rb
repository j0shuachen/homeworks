class Employee
  attr_reader :salary


  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier

  end

end

class Manager < Employee
  attr_accessor :underlings
  def initialize(name, title, salary, boss)
    super(name, title, salary, boss)
    @underlings = []
  end

  def bonus(multiplier)
    salaries = @underlings.reduce(0) {|accum, x| accum + x.bonus(1)}
    (salaries + @salary) * multiplier
  end




end

josh = Manager.new('Josh', 'CEO',4,nil)
graham = Manager.new('Graham','CTO',3,josh)

jack = Employee.new('Jack','Assistant to the Reigional Manager',1,graham)
josh.underlings << graham
graham.underlings << jack

p josh.bonus(1)
