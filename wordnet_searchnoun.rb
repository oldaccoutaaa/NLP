#!/usr/bin/ruby -Ku
# -*- coding: utf-8 -*-
require'rubygems'
require'sqlite3'


def opendb(lemma,pos)
	@high_means = []
	@high_means2 =[]
	@high_means_hype = []
	@high_means_hype2 = []
	db = SQLite3::Database.new "wnjpn2.db"
	rows = db.execute("select * from word where lemma = \"#{lemma}\" and pos = \"#{pos}\" ") 
	start_time = Time.now
	rows.each do|elm1|
		mining_wordid = db.execute("select * from sense where wordid = #{elm1[0]}")
		end_time = Time.now
		start_time2 = Time.now
		mining_wordid.each do|elm2|
			mining_syn = db.execute("select lemma from synlink, sense, word where link =\"hypo\" and synset1 = \"#{elm2[0]}\" and synset2 = synset and sense.wordid = word.wordid and word.lang=\"jpn\"")

			mining_syn_hype = db.execute("select lemma from synlink, sense, word where link =\"hype\" and synset1 = \"#{elm2[0]}\" and synset2 = synset and sense.wordid = word.wordid and word.lang=\"jpn\"")

			mining_syn.each do |hogehoge|
				end_time3 = Time.now
				@high_means << hogehoge
				@high_means1 =	@high_means.flatten
				@high_means2 =  @high_means1[0..10]
			end

			mining_syn_hype.each do |hype|
				end_time3 = Time.now
				@high_means_hype << hype
				@high_means_hype1 =	@high_means_hype.flatten
				#				@high_means_hype2 =  @high_means_hype1[0..10]
			end


		end
	end
end

noun_test_hash = Hash::new


open("noun_test2.txt") do |file|
	file.each_with_index do |s, s_num|
	#	p s.split
		noun_test_hash.store(s.split,s_num+1)		
	end
end
#p noun_test_hash.invert.fetch
hash_one =  noun_test_hash.invert.fetch(1)
@match_hype2 = []

for num in 0..hash_one.size - 1 do
	puts hash_one[num]
	opendb("#{hash_one[num]}","n")

	1.times do 
		@hogu_hypo = []
		p @high_means2.size
		@high_means2.size.times do |num_hypo|
			@hogu_hypo << @high_means2.pop
		end

		## @hogu �Ɍ������ʂ̏�ʌ�������
		##����each����@hogu�̂��ꂼ��̒P�����ʌ���	
		hogu_num_hypo = 0

		hogu_key_hypo = @hogu_hypo[hogu_num_hypo]	#�������ʂ̔C�ӂ̔ԍ����n�b�V���L�[�ɂ���
		opendb(hogu_key_hypo,"n")   
		hogu_value_hypo =  @high_means2 #�n�b�V���l�Ɍ������ʓ����
		hogu_hash_hypo = Hash.new		#�n�b�V�����
		hogu_hash_hypo.store("#{hogu_key_hypo}","#{hogu_value_hypo}")

		hogu_value_hypo.each do |each_key_hypo|	#�n�b�V���l�̏�ʌ�����ꂼ�꒲�ׂ�
			opendb(each_key_hypo,"n")
			hogu_value_hypo =  @high_means2
			hogu_hash_hypo.store("#{each_key_hypo}","#{hogu_value_hypo}")
			#�����Ƃ��Ƃ̃n�b�V���̒l����������L�[�ɂ��A���ʂ�l�ɂ���
			#�[���R�܂ł��
			hogu_value_hypo.each do |each_key_hypo2|
				opendb(each_key_hypo2,"n")
				hogu_value_hypo2 = @high_means2
				hogu_hash_hypo.store("#{each_key_hypo2}","#{hogu_value_hypo2}")
			end
		end

	end

	##��ʌꌟ��
	#while @high_means_hype1.size != 0
	1.times do 
		@match_hype = []
		@hogu = []
		@deep = []

		@high_means_hype1.size.times do |num|
			@hogu << @high_means_hype1.pop
		end
		@match_hype << @hogu	
		## @hogu �Ɍ������ʂ̏�ʌ�������
		##����each����@hogu�̂��ꂼ��̒P�����ʌ���	
		#	@deep = []

		#	p @hogu.size
		hogu_num = 0
		#	for up_cou in 1..@hogu.size
		@hogu.each do |hogu_each|
			hogu_key = hogu_each	#�������ʂ̔C�ӂ̔ԍ����n�b�V���L�[�ɂ���
			#	hogu_num += hogu_num + up_cou

			opendb(hogu_key,"n")   
			hogu_value =  @high_means_hype1 #�n�b�V���l�Ɍ������ʓ����
			hogu_hash = Hash.new		#�n�b�V�����
			hogu_hash.store("#{hogu_key}","#{hogu_value}")
			@match_hype << hogu_value
			##kokokara hukara hukakunaru
			#=begin	
			hogu_value.each do |each_key|	#�n�b�V���l�̏�ʌ�����ꂼ�꒲�ׂ�
				opendb(each_key,"n")
				hogu_value =  @high_means_hype1
				hogu_hash.store("#{each_key}","#{hogu_value}")
				#�����Ƃ��Ƃ̃n�b�V���̒l����������L�[�ɂ��A���ʂ�l�ɂ���
				#�[���R�܂ł��
				#	hogu_value.each do |each_key2|
				#		opendb(each_key2,"n")
				#		hogu_value2 = @high_means_hype1
				#		hogu_hash.store("#{each_key2}","#{hogu_value2}")
			end
			#=end

			#	end
			#p hogu_hash
		end
		dup_match = @match_hype.flatten
		dup_match.uniq
		@match_hype2 << dup_match.uniq
		#	end
	end
end
puts "hoge"
#p @match_hype2[2]
#puts @match_hype2[2]
#puts @match_hype2[0].size
puts "---------------------------------------------------------"
#puts @match_hype2[0]

answer = []
plus = 0
for match_num3 in 0..@match_hype2.size - 1
	#p "#{match_num3 + 1}""���"

	for match_num2 in 0..@match_hype2.size - 1
		for match_num in 0..@match_hype2[match_num2].size - 1 
			#	for match_num2 in 0..@match_hype2.size
			#p "#{match_num3}""���"
			#		match_num3 = 1
			check2 =  @match_hype2[match_num3].include?(@match_hype2[match_num2][match_num])

			if match_num3 != match_num2 && check2 then
				answer << match_num3 + 1
#				p "#{match_num3 + 1}" 
			#	puts"YES"
		#		plus += 1
	#		else
				#			puts "NO"
				#			plus += 1
			end	
	
		#	if plus == 1 then
		#		break
		#	end
		end
	end
end
p answer.uniq