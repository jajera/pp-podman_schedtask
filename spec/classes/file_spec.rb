require 'spec_helper'

describe 'podman::file' do
  context 'with names => {}' do
    let(:params) { { 'names' => {} } }

    it { is_expected.to compile }
  end

  context 'with names => :undef' do
    let(:params) { { 'names' => :undef } }

    it { is_expected.to compile }
  end

  context 'with names => ``' do
    let(:params) { { 'names' => '' } }

    it { is_expected.to compile.and_raise_error(%r{expects a Hash value}) }
  end

  context 'with names => 0' do
    let(:params) { { 'names' => 0 } }

    it { is_expected.to compile.and_raise_error(%r{expects a Hash value}) }
  end

  context 'with names => nil' do
    let(:params) { { 'names' => nil } }

    it { is_expected.to compile.and_raise_error(%r{expects a Hash value}) }
  end
end
