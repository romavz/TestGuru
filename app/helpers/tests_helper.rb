module TestsHelper
  def author_name (test)
    return test.author.name unless test.author.nil?

    "n/a"
  end
end
