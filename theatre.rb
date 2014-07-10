=begin 
 -------------------------------------------
Кастинг на роли в театре
-------------------------------------------

**********Роли***********

Роли бывают 2-х типов (женская/мужская) и для каждой роли есть свои возрастные ограничения (диапазон возрастов, например, 12-20).


**********Выступление********

На роль могут претендовать люди, подходящие по ее параметрам. Для того, чтоб получить роль, человеку нужно выступить перед комиссией. Выступление имеет тему, продолжительность и текст. Каждый человек может выступить только 1 раз на каждую подходящую роль. После чего 
его выступление оценивается каждым членом комиссии (оценкой за выступление считается средняя оценка всех членов комиссии). 

========Оценка выступления======

Максимальная оценка за выступление - 10 баллов. 

Члены комиссии оценивают выступление следующим образом: 
 - женщины не поставят больше 7 баллов за выступление, которое содержит меньше 30 слов
 - мужчины не поставят меньше 7 баллов девушкам 18-25 лет



*******Функции системы**********

- возможность показать наиболее подходящую роль для выступающего (у которой оценка больше остальных)
- посчитать общую продолжительность выступлений одного человека

=end

module Theatre
	GENDER = ['m','f']
	
	class Person
		attr_reader :gender, :age, :name

		def initialize(name,gender,age)
			raise ArgumentError unless GENDER.include? gender
			@name, @gender, @age = name, gender, age
		end

	end

	class Role < Person
	end


	class Actor < Person
		attr_accessor :performances

		def initialize(name,gender,age)
			super
			@performances = []
		end

		def max_suitable_role
			performances.max_by { | p| p.mark }
		end

		def total_length 
			performances.inject(0) { |sum,p| sum += p.length }
		end 

	end

	class Committee < Person
		@@committee = []
		def initialize(name,gender,age)
			super
			@@committee << self
		end

		def mark(actor,performance)
			raise TypeError unless performance.is_a? Performance
			if gender == 'm'
				actor.gender == 'f' && actor.age.between?(18,25) ? rand(7..10) : rand(0..10)
			else
				performance.speech.split.length > 30 ? rand(0..10) :  rand(0..7)
			end
		end

		def self.total_mark(actor,performance)
			sum = @@committee.inject(0) { |sum, c| sum += c.mark(actor,performance) }
			sum.to_f/@@committee.length
		end

	end

	class Performance
		attr_reader :role, :speech, :length, :mark

		def initialize(actor,role,theme,length,speech)
			raise TypeError, "#{actor.name} doesn't suit #{role.name} role" unless check_role(actor,role)
			@role, @theme, @length, @speech = role,theme,length,speech
			@mark = Theatre::Committee.total_mark(actor,self)
			puts "#{actor.name} total mark for #{role.name}:#{@mark}"
			actor.performances << self
		end

		def check_role(actor,role)
			raise TypeError, "Incorrect performance" unless (actor.is_a? Actor) && (role.is_a? Role)
			actor.performances.each do |p|
				raise ArgumentError, "You've already tried to take this role" if p.role == role
			end
			actor.gender == role.gender && role.age.include?(actor.age)
		end

	end

end


