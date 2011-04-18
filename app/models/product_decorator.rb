Product.class_eval do
  scope :google_base_scope, includes(:taxons, :images)
  
  def base_instance_store=(store)
    @store = store
  end
  
  protected
  
  def google_base_description
    self.description
  end
  
  def google_base_condition
    'new'
  end

  def google_base_link
    public_dir = @store.domains.match(/[\w\.]+/).to_s
    [public_dir.sub(/\/$/, ''), 'products', self.permalink].join('/')
  end
  
  def google_base_image_link
    public_dir = @store.domains.match(/[\w\.]+/).to_s
    if self.images.empty?
      nil
    else
      public_dir.sub(/\/$/, '') + self.images.first.attachment.url(:product)
    end
  end

  def google_base_product_type
    return nil unless Spree::GoogleBase::Config[:enable_taxon_mapping]
    product_type = ''
    priority = -1000
    self.taxons.each do |taxon|
      if taxon.taxon_map && taxon.taxon_map.priority > priority
        priority = taxon.taxon_map.priority
        product_type = taxon.taxon_map.product_type
      end
    end
    product_type
  end
end
