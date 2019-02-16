module TestsHelper
  def author_name (test)
    test.author&.name || 'n/a'

    "n/a"
  end
end
