Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                     :name => "converted_admin_configurations_menu",
                     :insert_after => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
                     :partial => "spree/admin/google_base_link",
                     :disabled => false)
