#!/opt/local/bin/ruby/u
# -*- mode:ruby; coding:utf-8 -*- 

require 'kconv'
require 'rubygems'
require 'hpricot'
require 'addressable/uri'
require 'open-uri'
require 'MeCab'

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
	str4 = str3.gsub(/[!-\/:-@\[-`{-~]/, "")
	
	@mecab_means <<  str4
}

count_words = Hash.new(0)
@noun_word = []
@mecab_means.each do |mecab_wakati|
	mecab = MeCab::Tagger.new()
	node = mecab.parseToNode(mecab_wakati)
	while node do
		noun = "–¼ŽŒ"
		adj  = "Œ`—eŽŒ"
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
p count_words.size

#search_url = http://ja.wikipedia.org/w/index.php?title=“Á•Ê%3AŒŸõ&profile=default&search=\"#{search_word}\"&fulltext=Search

p Math.log(880,635/348) 
      count_words.sort_by{|words,count| [count,words]}.each do |word,count|
	  count = (count/count_words.size) * Math.log(880,635/348) 
	   #    if count > 4 then
	     # puts "#{word}\t#{count}"
	   #  end
      end

end