class User < ActiveRecord::Base
  ROLES = {0 => :guest, 1 => :user, 2 => :moderator, 3 => :admin}

  attr_reader :role

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.location = get_social_location_for(user.provider,  auth_hash['info']['location'])
    user.image_url = auth_hash['info']['image']
    user.profile_url = get_social_url_for(user.provider, auth_hash['info']['urls'])
    user.save!

    user
  end

  def initialize
    @role = ROLES[0];
  end

  def role?(role_name)
    role == role_name
  end

  private
  def self.get_social_location_for(provider, location_hash)
    case provider
      when 'linkedin'
        location_hash['name']
      else
        location_hash
    end
  end

  def self.get_social_url_for(provider, url_hash)
    case provider
      when 'linkedin'
        url_hash['public_profile']
      else
        url_hash[provider.capitalize]
    end
  end
end
