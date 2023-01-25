class ApplicationController < ActionController::Base
  before_action :test_bad, only: [:badip]
  before_action :test_good, only: [:goodip]
  # before_action :check_ip_against_database
  before_action do
    # CODE FOR TESTING PURPOSES ONLY. DO NOT USE IN PRODUCTION.
    # GET YOUR OWN CODE AT projecthoneypot.org
    check_ip_against_database(ip_blacklists: {default: 'jbbqkzmcyeca'}, verbose: true)
  end

  def test_bad
    request.remote_ip = '127.1.40.1'
  end
  def test_good
    request.remote_ip = '127.1.10.1'
  end
end
