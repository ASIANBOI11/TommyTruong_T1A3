require './budgeting'
require 'tty-prompt'

describe Budgeting do
  describe 'edit budget' do
    # This checks that the value changing is an appropriate value in this context.
    # Shows the right value output of changing budget limit.
    it 'Allows number' do
      expect('12312').to match(/^[+]?([.]\d+|\d+[.]?\d*)$/)
    end
    it 'Does not allow characters' do
      expect('12asd2').not_to match(/^[+]?([.]\d+|\d+[.]?\d*)$/)
    end
    it 'Does not allow negative number' do
      expect('-999').not_to match(/^[+]?([.]\d+|\d+[.]?\d*)$/)
    end

    # Shows the right value output of changing the dates
    it 'Allows only a specific set of character and numbers in order to form dates' do
      expect('31/12/2003').to match(%r{(?<day>\d{1,2})/(?<month>\d{1,2})/(?<year>\d{4})})
    end
    it 'Does not allow input' do
      expect('312/as/2003').not_to match(%r{(?<day>\d{1,2})/(?<month>\d{1,2})/(?<year>\d{4})})
    end
  end

  describe 'File naming' do
    it 'Allows names' do
      expect('Tommy').to match(/^\S+$/)
    end
    it "Doesn't allow spaces" do
      expect('Tommy Truong').to_not match(/^\S+$/)
    end
  end
end
