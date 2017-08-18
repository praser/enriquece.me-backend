# frozen_string_literal: true

module V1
  class BaseController < ApplicationController
=begin
  @apiDefine AuthenticatedHeader
  @apiHeader {string} content-type The content type of request.
  Must always be filled with 'application/json'
  @apiHeader {string} Authorization Authentication token of current user
  @apiHeaderExample If you need an example of header, here you have it.
  Content-Type: application/json Authorization: Bearer <token>
=end

=begin
  @apiDefine UnauthenticatedHeader
  @apiHeader {string} content-type This is the content type of request.
  This header must always be filled with 'application/json'
  @apiHeaderExample If you need an example of header, here you have it.
  Content-Type: application/json
=end

=begin
  @apiDefine JsonApiObjectsArray
  @apiSuccess {Object[]} data
  @apiSuccess {String} data.id Id of object in database
  @apiSuccess {String} data.type Describes the type of object
=end

=begin
  @apiDefine JsonApiObject
  @apiSuccess {Object} data
  @apiSuccess {String} data.id Id of object in database
  @apiSuccess {String} data.type Describes the type of object
=end

=begin
  @apiDefine JsonApiObjectIncluded

  @apiSuccess {Object[]} included Array of objects with relationship data
  @apiSuccess {String} included.id Id of related object in database
  @apiSuccess {String} included.type Describes the type realted of object
  @apiSuccess {Object[]} included.attributes List attributes of a related object
=end

=begin
  @apiDefine JsonApiObjectAttributes
  @apiSuccess {Object[]} data.attributes List attributes of an object
=end

=begin
  @apiDefine JsonApiObjectRelationships

  @apiSuccess {Object[]} data.relationships
    Array of objects with relationship info
  @apiSuccess {Object} data.relationships.obj Object relationship
  @apiSuccess {Object} data.relationships.obj.data Object relationship info
  @apiSuccess {String} data.relationships.obj.data.id Object id in database
  @apiSuccess {String} data.relationships.obj.data.type Object object type
=end

=begin
  @apiDefine UnauthorizedError
  @apiError {json} unauthorized Authorization token is invalid, not provided or
  your access to this resource is not allowed.
  @apiErrorExample 401 - Unauthorized error response body:
  HTTP/1.1 401 Unauthorized
  {
    "errors": [
      {
        "source": {
          "pointer": "/data/attributes/<object>"
        },
        "detail": "Not Authorized"
      }
    ]
  }
=end

=begin
  @apiDefine UnprocessableEntity
  @apiError {json} unprocessable-entity
    Params providaded in request body are invalid or supressed
  @apiErrorExample 422 - Unprocessible Entity error response body:
  HTTP/1.1 422 Unprocessable Entity
  {
    "errors": [
      {
        "source": {
          "pointer": "/data/attributes/<object>"
        },
        "detail": "<error message>"
      }
    ]
  }
=end
  end
end
