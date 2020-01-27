# frozen_string_literal: true

# defining a common method for representing a response as a JSON
module Response

  # converts and object to JSON and sets the status of the response
  # @param [Object] object object to convert to JSON
  # @param [Symbol] status HTTP status of the response
  # @param [Array] incl defines a set of nested object elements to include in the JSON
  def json_response(object, status = :ok, incl = [])
    render json: object, include: incl, status: status
  end
end
