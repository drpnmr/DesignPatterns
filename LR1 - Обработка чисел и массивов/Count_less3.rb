#Найти количество цифр числа, меньших 3

def count_lessThen3 (n)
	count = 0
	while n!=0
		if n%10<3
			count+=1
		end
		n/=10
	end
	return count
end

puts "Введите число:"
n = gets.chomp.to_i
res = count_lessThen3(n)
puts "Количество цифр числа #{n}, меньших 3: #{res}"
	