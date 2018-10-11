class MailchimpSynchronizer
  API_KEY = Figaro.env.mailchimp_api_key
  LIST_ID = Figaro.env.mailchimp_list_id
  PAGE_SIZE = 100

  def self.clear_list!
    @mailchimp ||= connection
    emails = list_members.map { |m| { email: m['email'] }}
    @mailchimp.lists.batch_unsubscribe LIST_ID, emails , true, false, false
  end

  def self.fill_list!
    @mailchimp ||= connection
    emails = User.subscribed.map { |u| { email: { email: u.email }, merge_vars: { fname: u.first_name, lname: u.last_name }}}
    @mailchimp.lists.batch_subscribe LIST_ID, emails, false, true, true
  end

  def self.sync_all!
    clear_list!
    fill_list!
  end

  def self.list_members
    @list_members ||= get_list_members
  end

  def self.get_list_members(status = 'subscribed')
    @mailchimp ||= connection
    list_members = []
    (list_members_count / PAGE_SIZE + 1).times do |page|
      list_members += @mailchimp.lists.members(LIST_ID, status, { limit: PAGE_SIZE, start: page })['data']
    end
    list_members
  end

  def self.list_members_count
    @list_member_count ||= get_list_members_count
  end

  def self.get_list_members_count
    @list_member_count = connection.lists.members(LIST_ID, 'subscribed', { limit: 1 })['total'].to_i
  end

  def self.connection
    Mailchimp::API.new(API_KEY)
  end

  def initialize(user)
    @user      = user
    @mailchimp = MailchimpSynchronizer.connection
    @params    = [ LIST_ID, { email: @user.email }]
  end

  def sync!
    @user.subscription? ? subscribe! : unsubscribe!
  end

  def subscribe!
    @mailchimp.lists.subscribe(*subscribe_params)
  rescue Mailchimp::ListNotSubscribedError, Mailchimp::EmailNotExistsError, Mailchimp::ListInvalidImportError => e
    { error: e.message }
  end

  def unsubscribe!
    @mailchimp.lists.unsubscribe(*unsubscribe_params)
  rescue Mailchimp::ListNotSubscribedError, Mailchimp::EmailNotExistsError, Mailchimp::ListInvalidImportError => e
    { error: e.message }
  end

  def subscribe_params
    @params + [{ fname: @user.first_name, lname: @user.last_name }, 'html', false, true ]
  end

  def unsubscribe_params
    @params + [ false, false, false ]
  end
end
