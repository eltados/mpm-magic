class HasteBinUrl

  $base_url = "http://hastebin.com"
  def initialize(url)
    @id = url.gsub($base_url, "")
    @id = @id.gsub("/raw/", "")
  end

  def raw_url
    "#{$base_url}/raw/#{@id}"
  end

  def url
    "#{$base_url}/#{@id}"
  end

end
