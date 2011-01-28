class Admin::GoogleBaseSettingsController < Admin::BaseController
  helper :google_base
  
  def update
    config = Spree::GoogleBase::Config.instance
    config.update_attributes(params[:google_base_configuration])
    Rails.cache.delete("configuration_#{config.id}".to_sym)
    
    respond_to do |format|
      format.html {
        redirect_to admin_google_base_settings_path
      }
    end
  end

end
