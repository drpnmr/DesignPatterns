require './no_loop_methods.rb'

def get_array_from_input
    puts "Введите элементы массива через пробел:"
    gets.chomp.split.map(&:to_i)
end
  
def get_array_from_file
    puts "Введите путь к файлу:"
    file_path = gets.chomp
    if File.exist?(file_path)
        File.read(file_path).split.map(&:to_i)
    else
        puts "Файл не найден, массив будет пустым."
        []
    end
end

def get_array_from_input_or_file
    puts "Выберите способ ввода данных:"
    puts "1. Ввести с клавиатуры"
    puts "2. Чтение из файла"
    choice = gets.chomp.to_i
    
    if choice == 1
        get_array_from_input
    elsif choice == 2
        get_array_from_file
    else
        puts "Некорректный выбор. Ввод массива с клавиатуры."
        get_array_from_input
    end
end
  
def user_menu
    puts "Выберите задачу, которую хотите решить:"
    puts "1. Переставить в обратном порядке элементы массива, расположенные между его минимальным и максимальным элементами"
    puts "2. Найти два наибольших элемента массива"
    puts "3. Найти максимальный нечётный элемент"
    puts "4. Построить список с номерами элемента, который повторяется наибольшее число раз"
    puts "5. Построить массив из элементов, делящихся на свой номер и встречающихся в исходном массиве 1 раз"
  
    choice = gets.chomp.to_i
    case choice
    when 1
        array = get_array_from_input_or_file
        result = reverse_between_min_max(array)
        puts "Результат: #{result}"
    when 2
        array = get_array_from_input_or_file
        largest, second_largest = find_two_largest_elements(array)
        puts "Наибольшие элементы: #{largest}, #{second_largest}"
    when 3
        array = get_array_from_input_or_file
        result = max_odd_element(array)
        puts "Максимальный нечётный элемент: #{result}" 
    when 4
        array = get_array_from_input_or_file
        result = indices_of_most_frequent_elements(array)
        puts "Индексы элементов, которые повторяются наибольшее количество раз: #{result}"
    when 5
        array = get_array_from_input_or_file
        result = elements_divisible_by_index_and_unique(array)
        puts "Результат: #{result}"
    else
        puts "Некорректный выбор. Попробуйте снова."
    end
end
  
while true
    user_menu
    puts "\n"
end

  