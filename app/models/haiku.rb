class Haiku
  attr_reader :haiku
  def initialize(return_ary)
    @return_ary = return_ary
    @haiku = []
  end

  def create_haiku
    single_words
    find_line(5)
    find_line(7)
    find_line(5)
    return @haiku
  end

  def single_words
    @return_ary.each do |word|
      if word.split(' ').length > 1
        holder = word.clone
        @return_ary.delete(word)
        word.split(' ').each do |x|
          @return_ary << x
        end
      end
    end
    return @return_ary
  end



  def find_line(sylab)
    @return_ary = @return_ary.shuffle
    line = []
      @return_ary.each do |x|
          current = Word.where(word: x)[0] || false
        if current
          if current.syl <= sylab
            sylab = sylab - current.syl
            line << current.word
            @return_ary.delete(x)
          end
        end
      end
    @haiku << line
  end

end
