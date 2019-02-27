module TestsHelper
  def author_name(test)
    test.author&.first_name || 'n/a'
  end
end
