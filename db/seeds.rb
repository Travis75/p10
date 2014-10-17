def seed_db
  File.readlines('mhyph.txt').each do |line|
    x = line.force_encoding('UTF-8').encode('ascii', :invalid => :replace, :replace => '?')
    x = x.split('')
    p x.length
    x.pop; x.pop
      holder = ""
      count = 0
    x.each do |letter|
      if ("a".."z").include?(letter) || ("A".."Z").include?(letter)
        holder << letter
      else
        count += 1
      end
    end
    Word.create(word: holder, syl: count + 1)
  end
end