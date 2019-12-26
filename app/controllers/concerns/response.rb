# frozen_string_literal: true

# defining a common method for representing a response as a JSON
module Response

  def json_response(object, status = :ok, incl = [])
    render json: object, include: incl, status: status
  end
end
