# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  username               :string(255)
#  avatar                 :string
#  honey                  :string
#  stripe_id              :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  roles                  :string           default(["\"member\""]), is an Array
#

class User < ApplicationRecord
  validates :first_name, presence: true
  validates :first_name, format: { with: /[a-zA-Z]/ }
  validates :last_name, presence: true
  validates :last_name, format: { with: /[a-zA-Z]/ }
  before_save :set_username
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :roles, presence: true
  after_save :add_profile
  before_create :set_default_role
  after_save :maybe_add_stripe_id
  after_destroy :cancel_stripe_customer
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_one  :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  has_many :opportunities, dependent: :destroy
  has_many :story_ideas, dependent: :destroy
  has_many :todo_lists
  accepts_nested_attributes_for :todo_lists
  has_many :vnotes, dependent: :destroy
  has_many :agendas
  has_one_attached :avatar, dependent: :destroy
  validates :avatar, content_type: %i[png jpg]
  has_one :pledge, dependent: :destroy
  has_many :donations, dependent: :destroy

  ROLES = %w[member vestry communicator admin].freeze

  def set_default_role
    self.roles ||= ['member']
  end

  def add_role(role)
    self.roles << role unless has_role?(role)
  end

  def remove_role(role)
    self.roles.delete(role) if has_role?(role)
  end

  def role?(role)
    return false if self.roles.nil?

    self.roles.include?(role)
  end

  # honey used to prevent bots-filled forms from being saved to db
  validates :honey, absence: true

  # Include default devise modules
  # Others available are:
  # :lockable, :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :confirmable,
         :trackable

  def maybe_add_stripe_id
    return if stripe_id.present?

    customer = Stripe::Customer.create(email:)
    update(stripe_id: customer.id)
  end

  def cancel_stripe_customer
    Stripe::Customer.delete(stripe_id) if stripe_id
  end

  def add_profile
    create_profile if profile.nil?
  end

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def set_username
    self.username = "#{first_name.titleize} #{last_name.titleize.gsub(/'\w/,
                                                                      &:upcase)}"
  end
end
