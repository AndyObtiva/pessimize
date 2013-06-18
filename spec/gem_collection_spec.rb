require 'spec_helper'
require 'pessimize/gem_collection'

module Pessimize
  describe GemCollection do
    let(:collection) { GemCollection.new }

    context "adding a gem" do
      before { collection.add_gem('ponies', '>= 0.3.0') }
      subject { collection.all.first }

      its(:first) { should == 'ponies' }
    end
  end
end