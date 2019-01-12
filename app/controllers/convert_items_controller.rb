class ConvertItemsController < ApplicationController

	def index

		possible_string_size = [3,4,5,6,7,10]  ##1. as mentioned in program statement min str size should be 3, so this are the possible string size from the dictionary
		all_possible_combination = [[3,3,4],[3,4,3],[3,7],[4,3,3],[4,6],[5,5],[6,4],[7,3],[10]]  ## 2. depending on the above possibility these combination are possible
		file_element_arr = []
		temp_possible_combination = []
		temp_possible_combination_for_iteration = []
		temp_possible_combination_in_str = []
		integer_arr = {}
		output = []

		## input given
		hash = {2 => ['a','b','c'],3 => ['d','e','f'],4 => ['g','h','i'],5 => ['j','k','l'],6 => ['m','n','o'],7 => ['p','q','r','s'],8 => ['t','u','v'],9 => ['w','x','y','z']}

		#puts"please enter 10 digit number which should not contain 0 and 1"
		params[:query] = params[:query].present? ? params[:query] : ''
		number_arr = params[:query].strip.split('')
		start_time = Time.now  ### added to find the time difference
		### to get all possible combination from given interger from user
		all_possible_combination.each do |v|
			arr = []
			temp_number_arr = number_arr.clone
			v.each do |b|
				temp = temp_number_arr.shift(b)
				arr << temp.join('')
				temp_possible_combination_for_iteration << temp.join('').slice(0,3)
			end
			temp_possible_combination << arr
		end
		##########
		#####below arr of size 3 of each string 
		temp_possible_combination_for_iteration = temp_possible_combination_for_iteration.uniq
		##############
		######### from integer value get all the string value possible 
		temp_possible_combination_for_iteration.each do |k|
			num = k.split('')
			str = ''
			if num.size == 3
				hash[num[0].to_i].each do |p|
					hash[num[1].to_i].each do |q|
						hash[num[2].to_i].each do |r|
							str = p+q+r
							temp_possible_combination_in_str << str
						end
					end
				end
			elsif num.size == 4
				hash[num[0].to_i].each do |p|
					hash[num[1].to_i].each do |q|
						hash[num[2].to_i].each do |r|
							hash[num[2].to_i].each do |s|
								str = p+q+r+s
								temp_possible_combination_in_str << str
							end
						end
					end
				end
			end
		end
		##########end
		#####read file and get all present string from dictionary file
		File.open("#{Rails.root}/public/dictionary.txt").each do |line|
			line = line.gsub("\n",'')
		    file_element_arr << line if ( possible_string_size.include? line.size and temp_possible_combination_in_str.include? line.slice(0,3).downcase )
		end
		#############################
		concatenated_arr = temp_possible_combination.flatten.uniq


		file_element_arr.each do |g|
			str = ''
			g.split('').each do |u|
				if u != "\n"
					hash_val = hash.select{|k, value| k if value.include? u.downcase }
					str = str + hash_val.keys[0].to_s
				end
			end
			integer_arr[g] = str if concatenated_arr.include? str
		end

		hash_val = integer_arr.values
		temp_possible_combination.each do |v|
			temp = []
			v.each do |j|
				if hash_val.include? j.to_s
					temp << integer_arr.select{|k, h| h == j.to_s }
				else
					temp << nil
				end
			end
			output << temp
		end
		temp_arr = output.collect{|p| p if !p.include? nil}.compact
		@final_output = []
		####### combine all possible string to get all result
		temp_arr.each_with_index do |k,i|
			k[0].each do |j|
				if k[1] != nil && k[1] != ''
					k[1].each do |m|
						if k[2] != nil && k[2] != ''
							k[2].each do |n|
								@final_output << [j[0], m[0], n[0]]
							end
						else
							@final_output << [j[0],m[0]]
						end

					end
				else
					@final_output << [j[0]]
				end
			end
		end
		if @final_output == [] and params[:query].present?
			@final_output << "Data not present"
		end
		############
		end_time = Time.now
		puts"time taken=====#{(end_time - start_time)}"
	end
end
