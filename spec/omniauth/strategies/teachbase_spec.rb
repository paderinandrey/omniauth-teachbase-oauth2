# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Teachbase do
  let(:options) { {} }

  subject { described_class.new(nil, options) }

  describe '#client' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('teachbase')
    end

    it 'should have the correct site' do
      expect(subject.options.client_options.site)
        .to eq('https://go.teachbase.ru')
    end

    it 'should have the correct authorize url' do
      expect(subject.options.client_options.authorize_url)
        .to eq('/oauth/authorize')
    end

    it 'should have the correct token url' do
      expect(subject.options.client_options.token_url)
        .to eq('/oauth/token')
    end
  end

  describe '#callback_url' do
    let(:callback_url) { 'https://api.com/callback' }
    let(:options) { { callback_url: callback_url } }

    it 'has the correct callback url' do
      expect(subject.callback_url).to eq(callback_url)
    end
  end

  describe '#uid' do
    before :each do
      allow(subject).to receive(:raw_info) { { 'id' => 'uid' } }
    end

    it 'returns the id from raw_info' do
      expect(subject.uid).to eq('uid')
    end
  end

  describe '#info' do
    let(:raw_info_hash) { JSON.parse File.read('spec/fixtures/raw_info.json') }

    before do
      allow(subject).to receive(:raw_info).and_return(raw_info_hash)
    end

    %w[name email phone last_name first_name lang notice_email
       avatar_url accounts].each do |attr|

      it "should returns the #{attr}" do
        expect(subject.info[attr.to_sym]).to eq(raw_info_hash[attr])
      end
    end
  end

  describe '#extra' do
    before :each do
      allow(subject).to receive(:raw_info) { { foo: 'bar' } }
    end

    it { expect(subject.extra['raw_info']).to eq(foo: 'bar') }
  end
end
