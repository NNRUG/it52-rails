class String
  def to_url
    parsed = Addressable::URI.heuristic_parse(self).to_s
    parsed if parsed =~  URI::regexp(%w(http https))
  end
end
