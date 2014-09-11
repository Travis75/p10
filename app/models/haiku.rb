class Haiku
  def initialize(return_ary)
    @return_ary = return_ary
    @haiku = []
  end

  def create_haiku
    find_line(5)
    find_line(7)
    find_line(5)
    return @haiku
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
          end
        end
      end
    @haiku << line
  end

end