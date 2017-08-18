# frozen_string_literal: true

module V1
  # Defines actions that involve categories management
  class CategoriesController < V1::BaseController
    before_action :set_category, only: %i[show update destroy]

=begin
  @apiDefine CategoryAttributes
  @apiSuccess {String} data.attributes.name Category's name
=end

=begin
  @apiDefine CategoryParams
  @apiParam {String} name Give a name to your category
  @apiParamExample {json} Request body example
  {
    "name": "My new category"
  }
=end

=begin
  @apiDefine CategoryObjectExemple
  @apiSuccessExample {json} Success response body:
  HTTP/1.1 200 OK
  {
    "data": {
      "id": "598b1e9a3c6668000430fdf8",
      "type": "category",
      "attributes": {
        "name": "Transaporte"
      },
      "relationships": {
        "subcategories": {
          "data": []
        }
      }
    }
  }
=end

=begin
  @apiDescription You'll need a list of all categories for sure, and it is
  pretty easy to obtain and larg documented as well. The only thing you have to
  do is send a get request. Follow me, and I'll show you how.

  @apiVersion 1.0.0
  @api {get} /v1/categories List categories
  @apiName ListCategories
  @apiGroup Categories
  @apiPermission authenticated users only

  @apiUse AuthenticatedHeader

  @apiExample {curl} Look at this example to see how easy it is:
  Replace the <token> with the one returned to current user after login.

  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/categories

  @apiSuccessExample {json} This is the body of a response whith http status 200
  HTTP/1.1 200 OK
  {
    "data": [
      {
        "id": "5996cbf53c21e58e697af432",
        "type": "category",
        "attributes": {
          "name": "Moradia"
        },
        "relationships": {
          "subcategories": {
            "data": [
              {
                "id": "5996cc753c21e58e697af433",
                "type": "subcategory"
              }
            ]
          }
        }
      }
    ],
    "included": [
      {
        "id": "5996cc753c21e58e697af433",
        "type": "subcategory",
        "attributes": {
          "name": "Aluguel"
        },
        "relationships": {
          "category": {
            "data": {
              "id": "5996cbf53c21e58e697af432",
              "type": "categories"
            }
          }
        }
      }
    ]
  }

  @apiUse JsonApiObjectsArray
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse JsonApiObjectIncluded
  @apiUse CategoryAttributes
  @apiUse UnauthorizedError
=end
    def index
      @categories = Category.where(user_id: current_user.id)

      render_json_api(@categories)
    end

=begin
  @apiDescription Categorize transactions is a way to keep everything under
  control and track your money. It allow you to understand where your money is
  going and take more conscious decisions. As you are used to with our stile the
  proccess of creating a new category is prettyi simple and well documented. All
  you heve to do is trigger a authenticated post request following the pattern
  I'll show you from now.

  @apiVersion 1.0.0
  @api {post} /v1/categories Create category
  @apiName CreateCategory
  @apiGroup Categories
  @apiPermission authenticated users only

  @apiExample {curl} Try this example that I made for you:
  If I could give you some advice it would be for you to replace <token> with a
  valid authentication token. If I could give you another piece of advice, it
  would be for you to visit our authentication section to learn how to get the
  token.

  curl -i
  -X POST
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  -d '{"name": "My new category"}'
  https://api.enriquece.me/categories

  @apiUse CategoryParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse CategoryAttributes
  @apiUse CategoryObjectExemple
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def create
      @category = Category.new(category_params)
      attach_user

      return render_json_api_error(@category) unless @category.save

      props = { status: :created, location: v1_category_path(@category) }
      render_json_api(@category, props)
    end

=begin
  @apiDescription Some times changes are necessary and we understand it. If you
  whant to update your category this section was just made for you. You can
  reach this objective sending a put request as described below.

  @apiVersion 1.0.0
  @api {put} /v1/categories/:id Update category
  @apiName UpdateCategory
  @apiGroup Categories
  @apiPermission authenticated users only

  @apiParam {String} id Id of the category that will be changed. This attribute
  will be passed in url path.

  @apiExample {curl} Example usage:
  At this time I'll not say anithing about replacing the token marker with a
  valid one. I'm pretty sure that you know it.

  curl -i
  -X PUT
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  -d '{<json data>}'
  https://api.enriquece.me/categories/5996cbf53c21e58e697af432

  @apiUse CategoryParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse JsonApiObjectIncluded
  @apiUse CategoryAttributes
  @apiUse CategoryObjectExemple
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def update
      updated = @category.update(category_params)
      return render_json_api_error(@category) unless updated

      render_json_api(@category)
    end

=begin
  @apiDescription Categories also can be removed. Lets see how we can do it.

  @apiVersion 1.0.0
  @api {delete} /v1/categories/:id Delete category
  @apiName DeleteCategory
  @apiGroup Categories
  @apiPermission authenticated users only

  @apiParam {String} Id Id of the category that will be removed.

  @apiExample {curl} Another little example to help you.:
  I'll not say anymore about the <token>. You alredy know what to do about it.
  Don't you know it yet? Ok! Take a look at our authentication section.

  curl -i
  -X DELETE
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/categories/5996cbf53c21e58e697af432

  @apiUse AuthenticatedHeader
  @apiUse UnauthorizedError
=end
    def destroy
      @category.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find_by(id: params[:id], user_id: current_user.id)

      return unless @category.nil?
      current_user.errors.add :authorization, 'Not Authorized'
      render_json_api_error(current_user, :unauthorized)
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.permit(:name)
    end

    # Attach the current_user to category
    def attach_user
      @category.user = current_user
    end

    # Render response in JSON API format
    def render_json_api(object, options = { status: :ok, location: nil })
      render(
        json: object,
        status: options[:status],
        location: options[:location],
        include: %i[subcategories]
      )
    end
  end
end
