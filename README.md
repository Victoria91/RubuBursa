RubuBursa
=========
an example of using

s_m = Theatre::Actor.new('Johny Depp','m',33)
s_f = Theatre::Actor.new('Angelina Joli','f',23)
puts s_f.name
c1 = Theatre::Committee.new('Mike','m',34)
c2 = Theatre::Committee.new('Jane','f',34)
c3 = Theatre::Committee.new('Kate','f',34)
r_m = Theatre::Role.new('Gamlet','m',25..35)
r_f = Theatre::Role.new('Anna Karenina','f',22..30)
r_f2 = Theatre::Role.new('Juliette','f',22..30)
p = Theatre::Performance.new(s_m,r_m,'dfd',30,'dsfdfssdfdffdfsdfdfdsfsdffdsf')
p2 = Theatre::Performance.new(s_f,r_f,'dfd',300,'dsfdfssdfdffdfsdfdfdsfsdffdsf')
p3 = Theatre::Performance.new(s_f,r_f2,'dfd',300,'dsfdfssdfdffdfsdfdfdsfsdffdsf')
max = s_f.role
#puts sum
puts "Max = #{max.role.name}, total performances length: #{s_f.total_length}"
