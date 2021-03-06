# frozen_string_literal: true
# rubocop:disable RSpec/DescribedClass
require 'rails_helper'

RSpec.describe Persistence do
  let(:test_class) { Struct.new(:name) { include Persistence } }
  let(:model) { instance_double('User') }
  let(:params) { {name: 'game'} }
  let(:errored_response) do
    {json: {errors: :model_errors}, status: :unprocessable_entity}
  end
  subject { test_class.new('Persistence') }

  describe '#save_record' do
    it 'saves' do
      expect(model).to receive(:save).and_return(true)
      expect(subject).to receive(:render).with(json: model)
      subject.save_record(model)
    end

    it 'returns errors' do
      expect(model).to receive(:save).and_return(false)
      expect(model).to receive(:errors).and_return(:model_errors)
      expect(subject).to receive(:render).with(errored_response)
      subject.save_record(model)
    end

    it 'takes block for success' do
      expect(model).to receive(:save).and_return(true)
      expect(subject).to receive(:render).with(json: model)
      expect(model).to receive(:name)
      subject.save_record(model, &:name)
    end
  end

  describe '#update_record' do
    it 'updates' do
      expect(model).to receive(:update).with(params).and_return(true)
      expect(subject).to receive(:render).with(json: model)
      subject.update_record(model, params)
    end

    it 'returns errors' do
      expect(model).to receive(:update).with(params).and_return(false)
      expect(model).to receive(:errors).and_return(:model_errors)
      expect(subject).to receive(:render).with(errored_response)
      subject.update_record(model, params)
    end
  end

  describe '#destroy_record' do
    it 'destroys' do
      expect(model).to receive(:destroy).and_return(true)
      expect(subject).to receive(:head).with(:no_content)
      subject.destroy_record(model)
    end

    it 'returns errors' do
      expect(model).to receive(:destroy).and_return(false)
      expect(model).to receive(:errors).and_return(:model_errors)
      expect(subject).to receive(:render).with(errored_response)
      subject.destroy_record(model)
    end
  end
end
