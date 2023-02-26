# frozen_string_literal: true

RSpec.describe Post do
  let(:blog_post) { build :post }

  it 'validates post' do
    expect(blog_post.valid?).to be_truthy
  end

  it 'has slug validation' do
    blog_post.slug = nil
    expect(blog_post.valid?).not_to be_truthy
  end

  it 'has title validation' do
    blog_post.title = ''
    expect(blog_post.valid?).not_to be_truthy
  end

  it 'has unique slug validation', :db_depended do
    blog_post.save!
    another_post = build :post, slug: blog_post.slug
    expect(another_post.valid?).not_to be_truthy
  end
end
