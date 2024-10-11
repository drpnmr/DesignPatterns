#Найти количество чисел, не являющихся делителями исходного
#числа, не взамно простых с ним и взаимно простых с суммой простых
#цифр этого числа

def nod (a,b)
	while (b!=0)
		mod = a%b
		a=b
		b=mod
	end
	return a
end

def prostoe (n)
	if n==1
		return false
	end
	for i in 2...n-1
		if n%i==0
			return false
		end
	end
	return true
end

def sumProst (n)
	sum = 0
	while n!=0
		if prostoe(n%10)==true
			sum+=n%10
		end
		n/=10
	end
	return sum
end

puts "Введите число:"
n = gets.chomp.to_i
res=0
for i in 1..n
	if nod(n, i)!=1 && nod(sumProst(n), i) == 1 && (n % i) !=0
		res+=1
  end
end

puts "Количество чисел, не являющихся делителями #{n}, не взамно простых с ним и взаимно простых с суммой простых цифр этого числа: #{res}"