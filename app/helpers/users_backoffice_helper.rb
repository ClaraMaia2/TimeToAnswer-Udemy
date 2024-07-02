module UsersBackofficeHelper
  def avatar_image
    avatar = current_user.user_profile.avatar

    avatar.attached? ? avatar : 'img.jpg'
  end
end
