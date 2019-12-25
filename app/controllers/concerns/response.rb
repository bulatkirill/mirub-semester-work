# frozen_string_literal: true

# defining a common method for representing a response as a JSON
module Response

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
