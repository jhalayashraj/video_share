# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  it { is_expected.to validate_presence_of(:url) }
  it { should belong_to(:user) }
  it 'should validate video information' do
    subject.url = 'https://www.youtube.com/watch?v=pmXA9IlTKDU'
    subject.valid?
    expect(subject.errors[:url]).not_to include('is invalid')
    subject.url = 'https://www.youtube.com/watch?v=pmXA9'
    subject.valid?
    expect(subject.errors[:url]).to include('is invalid')
  end
end
