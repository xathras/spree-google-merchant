require 'net/ftp'

namespace :spree_google_base do

  task :generate => :environment do
    results = '<?xml version="1.0"?>' + "\n" + '<rss version="2.0" xmlns:g="http://base.google.com/ns/1.0">' + "\n" + _filter_xml(_build_xml) + '</rss>'
    File.open("#{RAILS_ROOT}/public/google_base.xml", "w") do |io|
      io.puts(results)
    end
  end
  
  task :transfer => :environment do
    ftp = Net::FTP.new('uploads.google.com')
    ftp.login(Spree::GoogleBase::Config[:ftp_username], Spree::GoogleBase::Config[:ftp_password])
    ftp.put("#{RAILS_ROOT}/public/google_base.xml", 'google_base.xml')
    ftp.quit() 
  end
  
end

def _filter_xml(output)
  fields = GOOGLE_BASE_FILTERED_ATTRS
  0.upto(fields.length - 1) { |i| output = output.gsub(fields[i] + '>', 'g:' + fields[i] + '>') }
  output
end
  
def _build_xml
  returning '' do |output|
    @public_dir = Spree::GoogleBase::Config[:public_domain] || ''
    xml = Builder::XmlMarkup.new(:target => output, :indent => 2, :margin => 1)
    xml.channel {
      xml.title Spree::GoogleBase::Config[:title] || ''
      xml.link @public_dir
      xml.description Spree::GoogleBase::Config[:description] || ''
      Product.google_base_scope.each do |product|
        xml.item {
          GOOGLE_BASE_ATTR_MAP.each do |k, v|
             value = product.send(v)
             xml.tag!(k, CGI.escapeHTML(value.to_s)) unless value.nil?
          end
        }
      end
    }
  end
end
