class SuperMemo
  GOOD_DELAY = 1
  NORMAL_DELAY = 2

  def initialize(params)
    @time = (params[:time].to_f / 1000) / 60
    @complexity = params[:complexity] ? (params[:complexity] < 1.3 ? 1.3 : params[:complexity]) : 2.5
    @times_reviewed = params[:times_reviewed]
    @typos = params[:typos]
    @word_length = params[:word_length]
  end

  def response_quality
    if @time <= GOOD_DELAY
      1
    elsif @time > GOOD_DELAY && @time <= NORMAL_DELAY
      2
    else
      3
    end
  end

  def rating
    if @typos.zero?
      { 1 => 5, 2 => 4, 3 => 3 }.fetch(response_quality)
    else
      typo_pct = @typos.percent_of(@word_length)
      if typo_pct < 20
        2
      elsif typo_pct <= 30
        1
      else
        0
      end
    end
  end

  def run
    case @times_reviewed
    when 0
      1
    when 1
      3
    else
      q = rating
      ((@times_reviewed - 1) * (@complexity + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02)))).round
    end
  end
end
