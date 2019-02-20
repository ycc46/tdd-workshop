class ErrorSerializer
  def initialize(model)
    @model = model
  end

  def serialized_json
    errors = @model.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          source: { pointer: "/data/attributes/#{field}" },
          detail: error_message
        }
      end
    end
    errors.flatten
  end
end
