require File.dirname(__FILE__) + '/../spec_helper'

describe Product do

  context "shoulda validations" do
    it { should have_many(:images) }
    it { should have_and_belong_to_many(:taxons) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:permalink) }
  end

  context "with GoogleBase support" do
    let(:product) { Factory(:product) }
    it 'should have a saved product record' do
      product.new_record?.should be_false
    end
    it 'should have google_base_condition' do
      product.send(:google_base_condition).should_not be_nil
    end
    it 'should have google_base_description' do
      product.send(:google_base_description).should_not be_nil
    end
    it 'should have google_base_link' do
      product.send(:google_base_link).should_not be_nil
    end
    context 'with enabled taxon mapping' do
      before do
        Spree::GoogleBase::Config.set :enable_taxon_mapping => true
      end
      specify { product.send(:google_base_product_type).should_not be_nil }
    end
    context 'with disabled taxon mapping' do
      before do
        Spree::GoogleBase::Config.set :enable_taxon_mapping => false
      end
      specify { product.send(:google_base_product_type).should be_nil }
    end
    context 'without images' do
      before do
        product.images.clear
      end
      specify { product.send(:google_base_image_link).should be_nil }
    end
    context 'with images' do
      before do
        Factory(:image, :viewable => product)
        product.reload
      end
      specify { product.send(:google_base_image_link).should_not be_nil }
      specify { product.send(:google_base_image_link).should == [Spree::GoogleBase::Config[:public_domain], "attachments/product/missing.png"].join }
    end
  end

end
