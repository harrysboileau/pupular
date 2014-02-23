class Dog < ActiveRecord::Base
  # let's alphabetize and put has_one above many
  has_many :friendships, foreign_key: "dog_id", class_name: "Friendship", dependent: :destroy
  has_many :pals, through: :friendships
  has_many :pending_friendships, foreign_key: "dog_id", class_name: "PendingFriendship", dependent: :destroy
  has_many :outstanding_requests, foreign_key: "pending_friend_id", class_name: "PendingFriendship", dependent: :destroy
  has_many :pending_pals, through: :pending_friendships
  has_one :profile
  has_many :sent_messages, foreign_key: "sender_id", class_name: "Message"
  has_many :inbox_messages
  has_many :received_messages, through: :inbox_messages
  has_many :events, foreign_key: "creator_id"
  has_many :event_attendances
  has_many :attended_events, through: :event_attendances
  has_many :sent_invitations, class_name: "Invitation", foreign_key: "dog_id", dependent: :destroy
  has_many :received_invitations, class_name: "Invitation", foreign_key: "invited_pal_id"
  has_many :invited_pals, through: :sent_invitations
  has_many :pending_events, through: :received_invitations

  attr_accessible :email, :password, :username, :name, :password_confirmation, :image

  scope :search, -> term { where('name ILIKE ? or username ILIKE ? or email ILIKE?', "%#{term}%", "%#{term}%", "%#{term}%") }

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
    self.username && self.name
  end

  def self.find_by_username_or_email(login)
    find_by_username(login) || find_by_email(login)
  end

  def validates_password?
    !!self.crypted_password
  end

  def validates_username?
    # username.nil?
    return (self.crypted_password || self.email ) && username == nil
  end

  def invitations
    self.received_invitations.where(declined: false)
  end

  def invited_to_events
    # can't an invitation just hold the event it's for?
    # so this can simplify to .map(&:event)
    self.invitations.map { |invitation| Event.find(invitation.event_id) }
  end

  def sent_requests
    # see above -- a request should probably know the dog it's for
    self.outstanding_requests.map{ |req| Dog.find(req.dog_id).username }
  end

end
