require 'spec_helper'
describe 'juju' do
  context 'with defaults for all parameters' do
    it { is_expected.to contain_class('juju') }
  end
end
