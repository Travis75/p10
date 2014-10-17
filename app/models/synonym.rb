class Synonym

  def self.break_results(ary)
    stripped = []
    ary["imageKeywords"].each do |x|
      stripped << x["text"]
    end
    return stripped
  end

  def self.get_syn(words)
    words.each do |x|
      yield x
    end
  end

end