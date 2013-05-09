# coding: utf-8
require 'mechanize'
require 'nokogiri'
require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

root_url = 'http://korneeva.com/'
#photos

photos_url = 'http://korneeva.com/photos.html'
photos_page = Nokogiri::HTML(open(photos_url), nil, 'UTF-8')

arc_arr = photos_page.xpath('//table/tr/td[2]/div/a[@class="grouped"]')
arc_arr.each do |node|
  url_part = node.children[1]['src']
  thumb_photo = "#{root_url}#{node.children[1]['src']}"
  full_photo = "#{root_url}#{node['href']}"
  photo_title = node['title']
  #Photo.find_or_create_by_title_and_small_photo_and_image_url( photo_title, thumb_photo, full_photo)
  Photo.create :title => photo_title, :small_photo => thumb_photo, :image_url => full_photo
end
puts "Photo #{Photo.all.length}" if Photo.all.length > 0

#videos
video_url = 'http://korneeva.com/video.html'
video_page = Nokogiri::HTML(open(video_url), nil, 'UTF-8')

all_frames = video_page.xpath('//iframe')
all_frames.each do |frame|
  VideoRecord.create :title => frame['title'], :youtube_url => frame['src']
end
puts "VideoRecord #{VideoRecord.all.length}" if VideoRecord.all.length > 0

#feedbacks
gb_url = 'http://korneeva.com/gb.php'
gb_page = Nokogiri::HTML(open(gb_url), nil, 'UTF-8')

all_feedbacks = gb_page.css('.guestMessage').last.text
date_arr =  all_feedbacks.scan(/\d{2}\.\d{1,2}\.\d{4}/)
string_array = all_feedbacks.split(/\d{2}\.\d{1,2}\.\d{4}/)
string_array.shift
check_code = Date.today.strftime("%Y")
string_array.each_with_index do |str_arr_el, i|

  date = date_arr[i]
  message_text = nil
  time, name, city, *message_text = str_arr_el.split("\r\n")
  time = time.scan(/\d{1,2}:\d{1,2}/).join

  if message_text.empty?
    message_text = city
    city = 'none'
  else
    message_text = message_text.join
  end
  created_at = "#{date} #{time}".to_datetime

  feedback = Feedback.new :name => name, :location => city, :body => message_text, :created_at => created_at, :check_code => check_code, :published => true
  feedback.save
end
puts "Feedback #{Feedback.all.length}" if Feedback.all.length > 0

#titov songs
titov_url = "http://www.korneeva.com/titov.html"
titov_page = Nokogiri::HTML(open(titov_url), nil, 'UTF-8')

rows = titov_page.xpath('//table[4]/tr/td[2]/center/center/table/tr')
rows.pop
rows.each do |row|
  song_name, song_length, authors = row.children[4].text.scan(/\A(.*?)\s-\s(.*?)\s[-\"]\s(.*)\z/).flatten
  unless authors
    song_name, authors = row.children[4].text.scan(/\A(.*?)\s-\s(.*)\z/).flatten
    song_length = ''
  end
  url_part = row.children[4].children[0].attributes['href'].value
  song_page_url = "#{root_url}#{row.children[4].children[0].attributes['href'].value}"
  song_page = Nokogiri::HTML(open(song_page_url), nil, 'UTF-8')
  url_to_mp3 = "#{root_url}#{song_page.at_xpath('//table[3]/tr/td[3]/a/@href').value.sub("\/", '')}"

  #Titov_song.find_or_create_by_title_and_song_length_and_authors_and_url_to_mp3(song_name, song_length, authors, url_to_mp3)
  TitovSong.create :title => song_name, :song_length => song_length, :authors => authors, :url_to_mp3 => url_to_mp3
end
puts "TitovSong #{TitovSong.all.length}" if TitovSong.all.length > 0

#songs
a = Mechanize.new
p = a.get('http://korneeva.com/repert.html')
table = p.parser.xpath "/html/body/table/tr[count(td)=4]"

table.each do |r|
  row = r.xpath "td"

  download_url = nil
  record_year = nil

  if row[1].xpath("a").any?
    download_url = "http://korneeva.com" + row[1].xpath("a")[0]['href']
    record_year = (/(\d\d\d\d)/.match(row[1].xpath("a")[0].children[0].text))[1]
  end

  name = (row[2].xpath("*/a")[0]).text
  text_url = row[2].xpath("*/a")[0]['href']
  author = row[3].text

  text_page = a.get(text_url)
  text_node = text_page.parser.xpath("//pre/b")[0]

  if text_node.nil?
    text_node = text_page.parser.xpath("//pre/i/i/b")[0]
  end

  text = text_node.text

  song = Song.new

  song.authors = author
  song.title  = name
  song.lyrics = text.gsub(/\r\n/, "<br>")

  song.record_year = record_year
  song.record_url = download_url

  text_page.links_with(:text => %r{Лист.*}i).each do |lnk|
    note_page = a.get("http://korneeva.com" + ( lnk.href.sub /.*\'(.*)\'.*/, '\1' ))
    notes = []
    notes << (note_page.parser.xpath("//img")[0]['src']).gsub(/\.\./, "http://korneeva.com")
    song.music_papers = notes
  end
  song.save
end
puts "Song #{Song.all.length}" if Song.all.length > 0
#disks

id = 0
url_main = "http://korneeva.com/disko.html"
doc = Nokogiri::HTML(open(url_main), nil, 'UTF-8')

title = Array.new
year = Array.new
doc.css('h1').each do |node|
  if /20/ =~ node.text
    string = node.text
    year.push(string[-9..-2])
    title.push(string[0..-11])
  end
end

body = Array.new
doc.css('div[class=disko]').each do |node|
  body.push(node.text.gsub(/\r\n/, "<br>"))
  id += 1
end

album_cover = Array.new
doc.css('div img').each do |node|
  if /jpg/ =~ node[:src] && ( (/4/ =~ node[:src]) != 8)
    album_cover.push("http://korneeva.com/" + node[:src].to_s)
  end
end

puts "Import to db Disk"

(id).times do |id|
  d = Disk.new(:id => id, :title => title[id], :body=> body[id], :year=> year[id],  :album_cover => album_cover[id])
  d.save
  puts "it's db Disk -- id database = #{d.id}"
end

puts "Disk #{Disk.all.length}" if Disk.all.length > 0
