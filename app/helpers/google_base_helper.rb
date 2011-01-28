module GoogleBaseHelper
  def setting_presentation_row(setting, hide_value = false)
    value = hide_value ? I18n.t(:not_shown) : Spree::GoogleBase::Config[setting].to_s
    value = "&mdash;" if value.blank?
    %(
    <tr>
      <th scope="row">#{I18n.t(setting, :scope => :google_base)}:</th> 
      <td>#{value}</td>
    </tr>).html_safe
  end
  
  def setting_field(form, setting)
    definition = GoogleBaseConfiguration.preference_definitions[setting.to_s]
    type = definition.instance_eval('@type').to_sym
    %(
    <p>
      #{form.label("preferred_#{setting}", I18n.t(setting, :scope => :google_base))}:<br />
      #{preference_field(form, "preferred_#{setting}", :type => type)}
    </p>).html_safe
  end
end
