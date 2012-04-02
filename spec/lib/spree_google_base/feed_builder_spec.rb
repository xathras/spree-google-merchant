require 'spec_helper'

describe SpreeGoogleBase::FeedBuilder do
  
  describe 'an instance' do
  
    describe 'in general' do
      before(:each) do
        Spree::GoogleBase::Config.set(:public_domain => 'http://mydomain.com')
        Spree::GoogleBase::Config.set(:store_name => 'Froggies')
        
        @builder = SpreeGoogleBase::FeedBuilder.new
        @xml = Builder::XmlMarkup.new(:target => @builder.output, :indent => 2, :margin => 1)
        @product = Factory(:product)
      end
      
      it 'should include products in the output' do
        @builder.build_product(@xml, @product)
        
        @builder.output.should include(@product.name)
        @builder.output.should include("products/#{@product.permalink}")
        @builder.output.should include(@product.price.to_s)
      end
      
      it 'should build the XML and not bomb' do
        @builder.build_xml
        
        @builder.output.should =~ /#{@product.name}/
        @builder.output.should =~ /Froggies/
      end
      
    end
  
    describe 'w/ store defined' do
      before(:each) do
        @store = Factory :store, :domains => 'www.mystore.com', :code => 'first', :name => 'Goodies, LLC'
        @store2 = Factory :store, :domains => 'www.anotherstore.com', :code => 'second', :name => 'Gifts, LLC'
        @builder = SpreeGoogleBase::FeedBuilder.new(:store => @store)
      end
      
      it "should know its path relative to the store" do
        @builder.path.should == "#{::Rails.root}/tmp/google_base_v#{@store.code}.xml"
      end
      
      it "should initialize with the correct domain" do
        @builder.domain.should == @store.domains.match(/[\w\.]+/).to_s 
      end
      
      it "should initialize with the correct scope" do
        @builder.scope.to_sql.should == Spree::Product.by_store(@store).google_base_scope.scoped.to_sql
      end
      
      it "should initialize with the correct title" do
        @builder.title.should == @store.name
      end
      
      it 'should include stores meta' do
        @xml = Builder::XmlMarkup.new(:target => @builder.output, :indent => 2, :margin => 1)
        @product = Factory(:product)
        
        @builder.build_meta(@xml)
        
        @builder.output.should =~ /#{@store.name}/
        @builder.output.should =~ /#{@store.domains}/
      end
      
      it 'should include only the right products' do
        @xml = Builder::XmlMarkup.new(:target => @builder.output, :indent => 2, :margin => 1)
        needed_product = Factory(:product, :stores => [@store])
        wrong_product = Factory(:product, :stores => [@store2], :name => 'This does NOT belong in the first store')
        
        @builder.build_xml
        @builder.output.should =~ /#{needed_product.name}/
        @builder.output.should_not =~ /#{wrong_product.name}/
      end
    end
    
    describe 'w/out stores' do
      
      before(:each) do
        Spree::GoogleBase::Config.set(:public_domain => 'http://mydomain.com')
        Spree::GoogleBase::Config.set(:store_name => 'Froggies')
        
        @builder = SpreeGoogleBase::FeedBuilder.new
      end
      
      it "should know its path" do
        @builder.path.should == "#{::Rails.root}/tmp/google_base_v.xml"
      end
      
      it "should initialize with the correct domain" do
        @builder.domain.should == Spree::GoogleBase::Config[:public_domain]
      end
      
      it "should initialize with the correct scope" do
        @builder.scope.to_sql.should == Spree::Product.google_base_scope.scoped.to_sql
      end
      
      it "should initialize with the correct title" do
        @builder.title.should == Spree::GoogleBase::Config[:store_name]
      end
      
      it 'should include configured meta' do
        @xml = Builder::XmlMarkup.new(:target => @builder.output, :indent => 2, :margin => 1)
        @product = Factory(:product)
        
        @builder.build_meta(@xml)
        
        @builder.output.should =~ /Froggies/
        @builder.output.should =~ /http:\/\/mydomain.com/
      end
    end
  end
  
  describe 'when misconfigured' do
    it 'should raise an exception' do
      SpreeGoogleBase::FeedBuilder.new.should raise_error
    end
  end
  
end
