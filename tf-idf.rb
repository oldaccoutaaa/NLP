?#!/opt/local/bin/ruby/u
# -*- mode:ruby; coding:utf-8 -*- 

require 'kconv'
require 'rubygems'
require 'hpricot'
require 'addressable/uri'
require 'open-uri'
require 'MeCab'
@now_count = 0
count_com = Hash.new
@mecab_means = []

url = 'http://ja.wikipedia.org/wiki/‚è‚ñ‚²'

#lemma = "‚è‚ñ‚²"
uri = Addressable::URI.parse(url)
p uri.scheme

p uri.normalize.to_s


open(uri.normalize.to_s){|f|
	str = f.read
	str1 = str.gsub(/?i<\/rp><rt>[^>]*<\/rt><rp>?j/,"").toutf8
	str2 = str1.gsub(/<\/?[^>]*>/, "")
	str3 = str2.gsub(/\s+/,'\d+')
	str0 = str3.gsub(/[!-\/:-@\[-`{-~]/, "")
		str4 = str0.gsub(/[0-9a-zA-Z]/,"")
		@mecab_means <<  str4
	}

	count_words = Hash.new(0)
	@noun_word = []
	@mecab_means.each do |mecab_wakati|
		mecab = MeCab::Tagger.new()
		node = mecab.parseToNode(mecab_wakati)
		while node do
			noun = "–¼Œ"
			adj  = "Œ`—eŒ"
			noun.force_encoding("ASCII-8BIT")
			adj.force_encoding("ASCII-8BIT")
			check_noun = node.feature.include?(noun)
			check_adj = node.feature.include?(adj)
			if check_noun
				#			puts node.surface		
				@noun_word << "#{node.surface}"
			end
			#		if  check_adj
			#			puts "#{node.surface}\t#{node.feature}"
			#		end

			node = node.next
		end

		@noun_word.each {|nouncount|
			count_words[nouncount] += 1
		}

		@count_words = ["nil",]
		count_words.sort_by{|words,count| [count,words]}.each do |word1,count1|
			@count_words << word1
		end 
		word_count = 0		
		#	now_count = 0
		p count_words.size
		
	#	puts"start"
	#	if @now_count <= 3 then
	#	puts "loop"
			count_words.sort_by{|words,count| [count,words]}.each do |word,count|
			if @now_count <= 100 then
				@now_count += 1
				puts "#{@now_count}"
				search_word = "#{word}"
				puts count_words.keys[word_count]

			#		puts search_word
			search_word1 ="#{count_words.keys[word_count]}"

#				p search_word1.force_encoding("utf-8")
				special = "“Á•Ê%3AŒŸõ"
				search_url = "http://ja.wikipedia.org/w/index.php?title=\"#{special}\"&profile=default&search=\"#{search_word1.force_encoding("utf-8")}\"&fulltext=Search"

				p search_url

				@search_num = []
				@idf = []
				#p search_uri.normalize.to_s
				search_uri = Addressable::URI.parse(search_url)
				#p search_uri.normalize.to_s


				open(search_uri.normalize.to_s){|f2|
					str = f2.read
					p		before = str.index(">v‚ÌŒŸõŒ‹‰Ê")
					p		after = str.index("Œ’†‚Ì")
					if  before == nil 
						next
					end
					_after =  after - 5
					_before = before + 11
					@idf << str[_before,_after-_before]

				}
				word_count +=1
				@idf = @idf.join(" ")
				@idf
				if @idf ==""
					next
				end
				puts "idf"
				puts @idf
			 count_all = (count.to_f/count_words.size).to_f * (Math.log(880635/@idf.to_i)).to_f
			
			
				#	@count_com << count_all = (count.to_f/count_words.size).to_f * (Math.log(880635/@idf.to_i)).to_f
			
			puts count_words.keys[word_count-1]
				puts count_all
				count_com.store("#{count_words.keys[word_count-1]}","#{count_all}")

			end
		end
	end
puts "count_start"	
	puts count_com.sort_by{|k,v| v}