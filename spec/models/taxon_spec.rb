require File.dirname(__FILE__) + '/../spec_helper'

describe Taxon do

  context "shoulda validations" do
    it { should have_one(:taxon_map) }
  end

end
