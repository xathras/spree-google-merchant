require 'spec_helper'

describe Spree::Taxon do

  context "shoulda validations" do
    it { should have_one(:taxon_map) }
  end

end
