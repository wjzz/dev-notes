require 'set'

RSpec.describe "example tests" do
    before(:all) {
        puts "<<< setup block for all tests in this group, run once"
    }

    before(:context) {
        puts "<<< setup block for all tests in this group, run once"
    }

    after(:all) {
        puts "<<< clenaup block for all tests in this group, run once"
    }

    before {
        puts "<<< setup block for every example in this group"
    }

    after {
        puts "<<< cleanup block for every example in this group"
    }

    it "should work", :aggregate_failures do
        expect([]).to be_empty
        expect([1,2,3]).not_to be_empty

        expect({}).to be_empty
        expect({:a => 1}).not_to be_empty

        expect(Set.new).to be_empty
        expect(Set.new([1,2,3])).not_to be_empty
        expect(Set.new([1,2,3])).to match_array [3,2,1]
    end

    it 'should also work' do
    end
end