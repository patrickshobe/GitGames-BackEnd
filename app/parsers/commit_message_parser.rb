class CommitMessageParser
  attr_reader :word_count

  def initialize
    @words = []
    @word_count = Hash.new(0)
  end

  def get_data(username)
    response = CommitMessageQuery.execute_query(username)
    if response[:error]
      @word_count = response
    else
      narrow_response(response)
    end
  end

  private

  def narrow_response(response)
    narrowed_response = response["user"]["repositories"]["nodes"]
    isolate_nodes(narrowed_response)
  end

  def isolate_nodes(response)
    response.each do |repository|
      unless repository.defaultBranchRef.nil?
        repository.defaultBranchRef.target.history.nodes.each do | commit |
          @words << commit.message.split
        end
      end
    end
    @words.flatten!
    count_valid_words
  end

  def count_valid_words
    @words.each do |word|
      @word_count[word.downcase] += 1 if word.length.between?(4, 20)
    end
  end
end
