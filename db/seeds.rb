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
  Photo.find_or_create_by_title_and_small_picture_and_image_url( photo_title, thumb_photo, full_photo)
end

#videos
video_url = 'http://korneeva.com/video.html'
video_page = Nokogiri::HTML(open(main_url), nil, 'UTF-8')

all_frames = video_page.xpath('//iframe')
all_frames.each do |frame|
  Video_record.create :title => fr['title'], :url => fr['src']
end

#feedbacks
gb_url = 'http://korneeva.com/gb.php'
gb_page = Nokogiri::HTML(open(gb_url), nil, 'UTF-8')

whole_text = gb_page.css('.guestMessage').last.text
all_feedbacks = gb_page.css('.guestMessage').last.text
date_arr =  all_feedbacks.scan(/\d{2}\.\d{1,2}\.\d{4}/)
str_arr = all_feedbacks.split(/\d{2}\.\d{1,2}\.\d{4}/)
str_arr.shift

str_arr.each_with_index do |str_arr_el, i|
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
  feedback = Feedback.create :name => name, :location => city, :body => message_text, :created_at => created_at
end

#titov songs
titov_url = "http://www.korneeva.com/titov.html"
titov_page = Nokogiri::HTML(open(url_main), nil, 'UTF-8')

rows = titov_page.xpath('//table[4]/tr/td[2]/center/center/table/tr')
rows.pop
rows.each do |row|
  without = ''
  song_name, song_length, authors = row.children[4].text.scan(/\A(.*?)\s-\s(.*?)\s[-\"]\s(.*)\z/).flatten
  unless authors
    song_name, authors = row.children[4].text.scan(/\A(.*?)\s-\s(.*)\z/).flatten
    song_length = nil
  end
  url_part = row.children[4].children[0].attributes['href'].value
  song_page_url = "#{root_url}#{row.children[4].children[0].attributes['href'].value}"
  song_page = Nokogiri::HTML(open(song_page_url), nil, 'UTF-8')
  url_to_mp3 = "#{root_url}#{song_page.at_xpath('//table[3]/tr/td[3]/a/@href').value.sub("\/", '')}"
  if song_length
    puts [song_name, song_length, authors, url_to_mp3]
  else
    puts [song_name, authors, url_to_mp3]
  end
end

#songs

#disks