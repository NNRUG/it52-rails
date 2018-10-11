class UpdateUserFromOmniauth
  attr_accessor :user, :provider, :data

  DELEGATED_METHODS = %i(email first_name last_name bio avatar_image nickname website)

  DELEGATED_METHODS.each do |method|
    delegate method, to: :user, allow_nil: true
  end

  def initialize(user, provider, data)
    @user = user
    @provider = provider
    @data = data
  end

  def save
    user.save
  end

  def set_attributes
    DELEGATED_METHODS.each do |method|
      self.send("set_#{method}".to_sym) if self.send(method).blank?
    end
    user
  end

  def set_email
    user.email  = data['email'] || ""
  end

  def set_first_name
    user.first_name = data['first_name'] || data['name'].split.first
  end

  def set_last_name
    user.last_name  = data['last_name'] || data['name'].split.last
  end

  def set_bio
    user.bio = data['description']
  end

  def set_avatar_image
    image_url = data['image']
    image_url.gsub!(/sz\=\d+/, 'sz=1024') if provider == 'google_oauth2'
    user.remote_avatar_image_url = image_url
  end

  def set_nickname
    user.nickname  = data['nickname'] || data['name'] || user.full_name
  end

  def set_website
    return user.website = nil if data['urls'].nil?
    url = data['urls']['Blog'] || data['urls']['Website']
    user.website = url.to_url unless url.nil?
  end
end
