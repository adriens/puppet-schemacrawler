require 'spec_helper'
describe 'schemacrawler' do

  context 'with defaults for all parameters' do
    it { should contain_class('schemacrawler') }
  end
end
