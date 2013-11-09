class Dog < ActiveRecord::Base
  has_many :friendships, foreign_key: "dog_id", class_name: "Friendship", dependent: :destroy
  has_many :pals, through: :friendships
  has_many :pending_friendships, foreign_key: "dog_id", class_name: "PendingFriendship", dependent: :destroy
  has_many :pending_pals, through: :pending_friendships
  has_one :profile
  has_many :sent_messages, foreign_key: "sender_id", class_name: "Message"
  has_many :inbox_messages
  has_many :received_messages, through: :inbox_messages
  has_many :events, foreign_key: "creator_id"
  has_many :event_attendances
  has_many :attended_events, through: :event_attendances

  attr_accessible :email, :password, :username, :name, :password_confirmation

  def accept_pal(pending_friend_id)
    request = self.pending_friendships.find_by_pending_friend_id(pending_friend_id)
    request.approve!
  end

  def deny_pal(pending_friend_id)
    request = self.pending_friendships.find_by_pending_friend_id(pending_friend_id)
    request.destroy
  end

  acts_as_authentic do |c|
    c.validates_length_of_password_field_options( { within: 6..20 } )

    c.merge_validates_confirmation_of_password_field_options({:unless => :validates_password?})
    c.merge_validates_length_of_password_field_options({:unless => :validates_password?})
    c.merge_validates_length_of_password_confirmation_field_options({:unless => :validates_password?})

    c.merge_validates_length_of_login_field_options( { :unless => :validates_username? })
    c.merge_validates_format_of_login_field_options( { :unless => :validates_username? })

    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end

  def is_registered?
    return self.username != nil && self.name != nil
  end

  def self.find_by_username_or_email(login)
    find_by_username(login) || find_by_email(login)
  end

  def validates_password?
    return self.crypted_password != nil
  end

  def validates_username?
    return (self.crypted_password != nil || self.email != nil) && username == nil
  end

  private

end
