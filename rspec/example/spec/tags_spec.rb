# bin/rspec spec/tags_spec.rb -fd --tag mail
# bin/rspec spec/tags_spec.rb -fd --tag db


RSpec.describe "example tags" do
    it "should work", mail: true do
    end

    it 'should also work', :mail, :db do
    end

    it 'should not work' do
    end
end
