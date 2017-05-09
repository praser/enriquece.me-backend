Quando(/^o backend receber uma requisição autenticada para o cadastramento de uma subcategoria de "([^"]*)" com os parâmetros$/) do |category_name, params|
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", "Bearer #{@token}"

  category = Category.find_by(name: category_name)
  params = JSON.parse(params)
  params['category_id'] = category.id.to_s

  post default_subcategories_path, params.to_json.to_s
end

Então(/^a subcategoria "([^"]*)" deve ser cadastrada$/) do |category_name|
  expect(Subcategory.find_by(name: category_name)).to_not be_nil
end

Então(/^a subcategoria "([^"]*)" deve estar relacionada a "([^"]*)"$/) do |subcategory_name, category_name|
	subcategory = Subcategory.find_by(name: subcategory_name)
	category = Category.find_by(name: category_name)

	expect(subcategory.category).to eq category
end

Então(/^a subcategoria "([^"]*)" deve estar presente na resposta\.$/) do |subcategory_name|
  body = JSON.parse(last_response.body)
	subcategory = Subcategory.find_by(name: subcategory_name)
	expect(body['data']['attributes']['name']).to eq subcategory.name
end