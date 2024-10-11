#Поиск минимального, максимального, первого положительного элемента массива

def find_min(arr)
	min = arr.first
	arr.each do |element|
		if element < min
			min = element
		end
	end
	return min
end

def find_max(arr)
	max = arr.first
	arr.each do |element|
		if element > max
			max = element
		end
	end
	return max
end

def find_pos1(arr)
	pos = 0
	for i in 0..arr.size-1
		if arr[i] > pos
			pos = arr[i]
			return i
		end
	end
end

print "Введите номер операции 1 - Поиск минимального элемента, 2 - Поиск максимального элемента, 3 - Поиск первого положительного элемента: "
operation = gets.chomp

print "Введите имя файла: "
filename = gets.chomp

arr = File.readlines(filename).map(&:to_i)

if operation == '1'
  puts "Минимальный элемент массива равен: #{find_min(arr)}"
elsif operation == '2'
  puts "Максимальный элемент массива равен: #{find_max(arr)}"
else
  puts "Номер первого положительного элемента равен: #{find_pos1(arr)+1}"
end


