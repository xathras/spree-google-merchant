class GoogleBaseConfiguration < Configuration
  preference :title, :string, :default => 'My Site'
  preference :public_domain, :string, :default => 'http://www.mysite.com/'
  preference :description, :text, :default => 'My Description'
  preference :ftp_username, :string, :default => ''
  preference :ftp_password, :password, :default => ''
  preference :enable_taxon_mapping, :boolean, :default => false
end
