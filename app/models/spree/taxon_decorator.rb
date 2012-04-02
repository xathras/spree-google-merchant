module Spree
  Taxon.class_eval do
    has_one :taxon_map
  end
end
