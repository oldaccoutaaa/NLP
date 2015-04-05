#!/usr/bin/ruby -Ku
# -*- coding: utf-8 -*-

require 'rubygems'
require 'sqlite3'
#gem 'shoes','3.0.1'
#require "shoes"

class WNJpn

  Word = Struct.new("Word",:wordid, :lang, :lemma, :pron, :pos)
  Sense = Struct.new("Sense",:synset, :wordid, :lang, :rank, :lexid, :freq, :src)
  Synset = Struct.new("Synset",:synset, :pos, :name, :src)
  SynLink = Struct.new("SynLink",:synset1, :synset2, :link, :src)
  SynsetDef = Struct.new("SynsetDef",:synset, :lang, :def, :sid)

  def self.hello
	puts"print test"
	  #puts"#{ARGV[0]}"
	 # print(msg + "," + name + "\n")
  end

  def initialize(dbfile)
p    @conn = SQLite3::Database.new(dbfile)
  end

  def get_words(lemma)
    @conn.execute(
      "select * from word where lemma=?",lemma) \
      .map{|row|Word.new(*row)}
  end

  def get_words(lemma, pos)
    @conn.execute(
      "select * from word where lemma=? and pos=?",lemma,pos) \
    .map{|row|Word.new(*row)}
  end

  def get_word(wordid)
    Word.new(*@conn.get_first_row(
      "select * from word where wordid=?",wordid))
  end

  def get_senses(word)
    @conn.execute(
      "select * from sense where wordid=?",(word.wordid)) \
      .map{|row|Sense.new(*row)}
  end

  def get_sense(synset, lang="jpn")
    row = @conn.get_first_row(
      "select * from sense where synset=? and lang=?",synset,lang)
    row ? Sense.new(*row) : nil
  end

  def get_synset(synset)
    row = @conn.get_first_row("select * from synset where synset=?",synset)
    row ? Synset.new(*row) : nil
  end

  def get_syn_links(sense, link)
    @conn.execute(
      "select * from synlink where synset1=? and link=?",sense.synset,link) \
    .map{|row|SynLink.new(*row)}
  end

  def get_syn_links_by_synset1(sense)
    @conn.execute(
      "select * from synlink where synset1=?",sense.synset) \
    .map{|row| SynLink.new(*row)}
  end
  
  def get_synset_def(synset)
    row = @conn.get_first_row(
      "select * from synset_def where synset=?",synset)
    row ? SynsetDef.new(*row) : nil
  end

  def get_sys_links_all(senses)
    senses.each do |sense|
      synset_def = get_synset_def(sense.synset)
      puts  "- def: #{synset_def.def}\n"
      @link_map = {}
      get_syn_links_by_synset1(sense).each do |syn_link|
        sense2 = get_sense(syn_link.synset2,'jpn')
        @link_map[syn_link.link] = [] if @link_map[syn_link.link].nil?
        @link_map[syn_link.link] \
        .push "#{get_synset(sense2.synset).name}" + \
        " (#{get_word(sense2.wordid).lemma})" \
         unless sense2.nil?
      end
      @link_map.each{|link,text|
        puts "  #{link}:\n    - #{text.join("\n    - ")}" \
        unless text.empty?
      }
    end
  end

  def main(word,pos)
      puts"start"
      get_words(word,pos).each do |word|
p word
      puts"loop"
      senses = get_senses(word)
#      p senses
      get_sys_links_all(senses)
    end
      puts "test"
  end


  def self.print_usage
    puts <<-EOS
usage: wn.rb word pos
    word      word to investigate
    pos       
      n  - noun
      v  - verb
      a  - adjective
      r  - adverb

    link
      hype - Hypernyms
      inst - Instances
      hypo - Hyponym
      hasi - Has Instances
      mmem - Meronyms --- Member
      msub - Meronyms --- Substance
      mprt - Meronyms --- Part
      hmem - Holonyms --- Member
      hsub - Holonyms --- Substance
      hprt - Holonyms -- Part
      attr - Attributes
      sim  - Similar to
      also - Also
      enta - Entails
      caus - Causes
      dmnc - Domain --- Category
      dmnu - Domain --- usage
      dmnr - Domain --- Region
      dmtc - In Domain --- Category
      dmtu - In Domain --- usage
      dmtr - In Domain --- Region

    lang (default: jpn)
      jpn - Japanese
      eng - English
    EOS
  end

  def close_db
    @conn.close
  end

end

if __FILE__ == $0
  if ARGV.length >= 2
    dbfile = "wnjpn.db"
    wnj = WNJpn.new(dbfile)
    wnj.main(*ARGV)
    wnj.close_db
  else
    WNJpn.print_usage
  end
end