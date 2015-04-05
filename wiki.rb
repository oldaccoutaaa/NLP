?#!/opt/local/bin/ruby/u
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

=begin
open(uri.normalize.to_s) do |f|
	  p f.status
	    # => ["200", "OK"]
	   puts f
	  #     # => #
	       end
=end

#url = 'http://www.aozora.gr.jp/cards/001091/files/42311_15546.html'

open(uri.normalize.to_s){|f|
	str1 = f.read
	str = str1.gsub(/?i<\/rp><rt>[^>]*<\/rt><rp>?j/,"").toutf8
	str2 = str.gsub(/<\/?[^>]*>/, "")
	@mecab_means <<  str2
}



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
			puts "#{node.surface}\t#{node.feature}"
		end
		if  check_adj
			puts "#{node.surface}\t#{node.feature}"
		end

		node = node.next
	end
end