require 'spec_helper'

describe 'podman::package' do
  context 'podman' do
    it 'must be installed' do
      is_expected.to contain_package('podman').with_ensure('present')
    end
  end
  context 'podman-plugins' do
    it 'must be installed' do
      is_expected.to contain_package('podman').with_ensure('present')
    end
  end
end
