require 'spec_helper'

describe Spree::Product do

  context "with GoogleBase support" do
    let(:product) { Factory(:product) }
    
    it 'should have a saved product record' do
      product.new_record?.should be_false
    end
    
    it 'should have google_base_condition' do
      product.google_base_condition.should_not be_nil
    end
    
    it 'should have google_base_description' do
      product.google_base_description.should_not be_nil
    end
    
    it 'should have google_base_link' do
      product.google_base_link.should_not be_nil
    end
    
    context 'with enabled taxon mapping' do
      before do
        Spree::GoogleBase::Config.set :enable_taxon_mapping => true
      end
      specify { product.google_base_product_type.should_not be_nil }
    end
    
    context 'with disabled taxon mapping' do
      before do
        Spree::GoogleBase::Config.set :enable_taxon_mapping => false
      end
      specify { product.google_base_product_type.should be_nil }
    end
    
    context 'without images' do
      before do
        product.images.clear
      end
      specify { product.google_base_image_link.should be_nil }
    end
    
    context 'with images' do
      before(:each) do
        Factory(:image, :viewable => product)
        product.reload
      end
      specify { product.google_base_image_link.should_not be_nil }
      specify { product.google_base_image_link.should == [Spree::GoogleBase::Config[:public_domain], "attachments/product/missing.png"].join }
    end
    
  end

end
