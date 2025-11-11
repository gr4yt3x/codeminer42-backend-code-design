class Book
  attr_reader :id, :title, :author

    def initialize(id:, title:, author:)
    raise ArgumentError, "ID cannot be nil" if id.nil? || id.empty?
    raise ArgumentError, "Title cannot be blank" if title.nil? || title.strip.empty?
    raise ArgumentError, "Author cannot be blank" if author.nil? || author.strip.empty?

    @id     = id
    @title  = title.strip
    @author = author.strip
  end

  def to_h
    {
      id: @id,
      title: @title,
      author: @author
    }
  end
end
