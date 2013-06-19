require 'spec_helper'

describe "running pessimize" do
  include IntegrationHelper

  before do
    setup
  end

  after do
    tear_down
  end

  context "with a simple Gemfile and Gemfile.lock" do
    let(:gemfile) { <<-EOD
gem 'json'
gem 'rake'
      EOD
    }

    let(:lockfile) { <<-EOD
GEM
  remote: https://rubygems.org/
  specs:
    json (1.2.4)
    rake (10.0.4)
      EOD
    }

    before do
      write_gemfile(gemfile)
      write_gemfile_lock(lockfile)

      run
    end

    context "the return code" do
      subject { $? }
      it { should == 0 }
    end

    context "the Gemfile.backup" do
      it "should be created" do
        File.exists?(tmp_path + 'Gemfile.backup').should be_true
      end

      it "should be the same as the original Gemfile" do
        gemfile_backup_contents.should == gemfile
      end
    end

  end
end