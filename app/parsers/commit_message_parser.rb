class CommitMessageParser
  attr_reader :words

  def initialize
    @words = []
  end

  def get_data(username)
    commit_query = CommitMessageQuery.new
    response = commit_query.query(username)
    narrow_response(response)
  end

  def narrow_response(response)
    narrowed_response = response.data.user.repositories.nodes
    isolate_nodes(narrowed_response)
  end

  def isolate_nodes(response)
    response.each do |repository|
      if repository.defaultBranchRef.nil?
        next
      else
        repository.defaultBranchRef.target.history.nodes.each do | commit |
          @words << commit.message.split
        end
      end
    end
  end

end
