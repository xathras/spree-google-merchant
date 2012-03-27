class Spree::Admin::GoogleBaseSettingsController < Spree::Admin::BaseController
  helper 'spree/admin/google_base'
  
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
