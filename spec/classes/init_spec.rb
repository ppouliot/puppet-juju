require 'spec_helper'
describe 'juju' do

  context 'with defaults for all parameters' do
    it { should contain_class('juju') }
  end
end
