activate :dotenv
activate :blog do |blog|
  blog.new_article_template = 'templates/new.erb'
end
