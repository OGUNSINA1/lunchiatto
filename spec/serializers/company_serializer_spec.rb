# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CompanySerializer do
  let(:company) { instance_double('Company') }
  let(:users) { class_double('User') }
  subject { described_class.new company }

  describe '#users' do
    it "sorts'em" do
      expect(users).to receive(:by_name) { :sorted_users }
      expect(company).to receive(:users) { users }
      expect(subject.users).to eq(:sorted_users)
    end
  end
end
