class String
  def to_base62_decode
    Base62.decode(self)
  end
end
