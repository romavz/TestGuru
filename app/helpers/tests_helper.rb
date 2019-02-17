module TestsHelper
  def author_name (test)
    test.author&.name || 'n/a'
  end
end
