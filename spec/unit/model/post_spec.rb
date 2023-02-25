# frozen_string_literal: true

RSpec.describe Post, :db_depended do
  def valid_post
    Post.new slug: 'post-slug', title: 'post title'
  end

  it 'validates right post' do
    expect(valid_post.valid?).to be_truthy
  end

  it 'has slug validation' do
    post = valid_post
    post.slug = nil
    expect(post.valid?).not_to be_truthy
  end

  it 'has title validation' do
    post = valid_post
    post.title = ''
    expect(post.valid?).not_to be_truthy
  end

  it 'has unique slug validation', :isolated do
    post = valid_post
    post.save!

    expect(valid_post).not_to eq(post)
  end
end
