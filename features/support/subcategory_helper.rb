# frozen_string_literal: true

module SubcategoryHelper
  def find_subcategory(field = {})
    Subcategory.find_by(field)
  end

  def create_subcategory(category, data)
    FactoryGirl.create(
      :subcategory,
      name: data['nome'],
      category: category
    )
  end

  def attributes_for_subcategory(category, params)
    json = JSON.parse(params)
    FactoryGirl.attributes_for(
      :subcategory,
      name: json['name'],
      category_id: category.id.to_s
    ).to_json
  end
end

World SubcategoryHelper
