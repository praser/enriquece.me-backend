# frozen_string_literal: true

module V1
  # Defines actions that involve subcategories management
  class SubcategoriesController < V1::BaseController
    before_action :set_subcategory, only: %i[show update destroy]

=begin
  @apiDefine SubcategoryAttributes
  @apiSuccess {String} data.attributes.name Subcategory name
=end

=begin
  @apiDefine SubcategoryParams
  @apiParam {String} name Name of the sucategory
  @apiParam {String} category_id Id of parent category. To
  learn how to obtain values to fill this attribute take a look in category
  section of this documentation.
  @apiParamExample {json} Request body example
  {
    "name": "Gasolina",
    "category_id": "598b1e9a3c6668000430fdf8"
  }
=end

=begin
  @apiDefine SubcategoryObjectExemple
  @apiSuccessExample {json} This is the body of a http 200 response
  HTTP/1.1 200 OK
  {
    "data": {
      "id": "598c3834c54c8e0004f66518",
      "type": "subcategory",
      "attributes": {
          "name": "Gasolina"
      },
      "relationships": {
        "category": {
          "data": {
            "id": "598b1e9a3c6668000430fdf8",
            "type": "categories"
          }
        }
      }
    }
  }
=end

=begin
  @apiDescription To be more specific about money flow, users can create
  subcategories to better organize his financial transactions. A subcategory is
  a category inside a category. It's management is simple and this part of the
  documentation describes how to create a new subcategory.

  @apiVersion 1.0.0
  @api {post} /v1/subcategories Create subcategory
  @apiName CreateSubcategory
  @apiGroup Subcategory
  @apiPermission authenticated users only

  @apiExample {curl} Example usage:
  curl -i
  -X POST
  -d '{<json data>}'
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/subcategories

  @apiUse SubcategoryParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse SubcategoryAttributes
  @apiUse SubcategoryObjectExemple
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def create
      @subcategory = Subcategory.new(subcategory_params)

      return render_json_api_error(@subcategory) unless @subcategory.save
      props = { status: :created, location: v1_subcategory_path(@subcategory) }
      render_json_api(@subcategory, props)
    end

=begin
  @apiVersion 1.0.0
  @api {put} /v1/subcategories/:id Update account
  @apiName UpdateSubcategory
  @apiGroup Subcategory
  @apiPermission authenticated users only

  @apiParam {String} Id Subcategory id

  @apiExample {curl} Example usage:
  curl -i
  -X PUT
  -d '{<json data>}'
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/subcategories/<id>

  @apiUse SubcategoryParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse SubcategoryAttributes
  @apiUse SubcategoryObjectExemple
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def update
      updated = @subcategory.update(subcategory_params)
      return render_json_api_error(@subcategory) unless updated
      render_json_api(@subcategory)
    end

=begin
  @apiVersion 1.0.0
  @api {delete} /v1/subcategories/:id Delete account
  @apiName DeleteSubcategory
  @apiGroup Subcategory
  @apiPermission authenticated users only

  @apiParam {String} Id Subcategory id

  @apiExample {curl} Example usage:
  curl -i
  -X DELETE
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/subcategories/<id>

  @apiUse AuthenticatedHeader
  @apiUse UnauthorizedError
=end
    def destroy
      @subcategory.destroy
    end

    private

    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
      @subcategory = nil if @subcategory.category.user != current_user

      return unless @subcategory.nil?
      current_user.errors.add :authorization, 'Not Authorized'
      render_json_api_error(current_user, :unauthorized)
    end

    # Only allow a trusted parameter "white list" through.
    def subcategory_params
      params.permit(:name, :category_id)
    end
  end
end
