# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    Post.delete_all
  end

  config.around(:example, :isolated) do |example|
    Post.delete_all
    example.run
  end
end
