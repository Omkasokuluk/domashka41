module PostsHelper 
  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 2
    count_likers(votes)
  end 
  def count_likers(votes)
    vote_count = votes.size
    vote_count.to_s + ' likes'
  end
  def list_likers(votes)
    user_names = []

    unless votes.blank?
      votes.voters.each do |voter|

        user_names.push(link_to voter.name,
                                user_path(voter),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end
  def liked_post(post)  
    return 'glyphicon-heart' if current_user.voted_for? post
    'glyphicon-heart-empty'
  end

  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end  