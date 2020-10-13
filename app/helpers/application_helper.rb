module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friendship_id_generator(arg1, arg2)
    [arg1, arg2].sort.join('').to_i
  end

  def friendship_checker(user, friendship_id)
    return if current_user == user

    if current_user.friends.include?(user)
      content_tag :span do
        content_tag(:b, 'Friends ') +
          content_tag(:small,
                      (link_to 'Unfriend', friendship_path(friendship_id),
                               method: :delete, data: { confirm: 'Are you sure you want to unfriend this person?' }))
      end

    elsif current_user.pending_friends.include?(user)
      content_tag(:b, 'Friend Request sent ...')

    elsif current_user.friend_requests.include?(user)
      content_tag :span do
        content_tag(:b, (link_to 'Accept request', friendship_path(friendship_id), method: :put)) +
          content_tag(:span, ' ') +
          content_tag(:small,
                      (link_to 'Reject request', friendship_path(friendship_id),
                               method: :delete, data: { confirm: 'Are you sure you want to reject this request?' }))
      end

    else
      link_to 'Add as friend', friendships_path(friendee_id: user.id), method: :post
    end
  end
end
