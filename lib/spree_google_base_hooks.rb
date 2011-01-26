class SpreeGoogleBaseHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_configurations_menu, 'admin/google_base_link'
end
