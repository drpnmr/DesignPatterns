if ARGV.empty?
  name="Аноним"
else
  name = ARGV.first
end
puts "Здравствуй, #{name}!"
puts "Какой твой любимый язык программирования?"

lang = STDIN.gets.chomp 

if lang == "Ruby"
	puts "Ого, #{name}, оказывается ты подлиза^^"
else 
	puts "А скоро будет Ruby)"
	
	if lang == "Python"
		puts "Интересно..Очень интересно..."
			
	elsif lang == "C++"
		puts "Хороший выбор!"
			
	elsif lang == "C#"
		puts "Ого, нравится ООП? Но все же попробуй Ruby."
	end
end

puts "Пожалуйста, введите команду для Ruby:"
ruby = STDIN.gets.chomp
puts "Теперь команду для ОС:"
op_s = STDIN.gets.chomp

begin
  eval(ruby)
  system(op_s)
rescue StandardError => e
  puts "Ошибка при выполнении команд: #{e.message}"
end
