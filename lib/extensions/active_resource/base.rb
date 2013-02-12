class ActiveResource::Base
  def update_empty_attributes attributes
    attributes.each do |key, value|
      if self.send(key).to_s.empty?
        self.send("#{key}=".to_sym, value)
        self.save
      end
    end
  end
end

