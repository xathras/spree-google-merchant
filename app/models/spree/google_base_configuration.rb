module Spree
  class GoogleBaseConfiguration < Preferences::Configuration
    preference :store_name, :string, :default => ''
    preference :public_domain, :string
#    preference :description, :text, :default => ''
    preference :ftp_username, :string, :default => ''
    preference :ftp_password, :password, :default => ''
    preference :enable_taxon_mapping, :boolean, :default => false
  end
end
