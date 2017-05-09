Dado(/^a existência das subcategorias abaixo no sistema:$/) do |table|
  table.hashes.each do |data|
    FactoryGirl.create(:subcategory, {
      name: data['nome'],
      category: Category.find_by(name: data['categoria'])
    })
  end
end

Quando(/^o backend receber uma requisição autenticada para o cadastramento de uma subcategoria de "([^"]*)" com os parâmetros$/) do |category_name, params|
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", "Bearer #{@token}"

  category = Category.find_by(name: category_name)
  params = JSON.parse(params)
  params['category_id'] = category.id.to_s

  post default_subcategories_path, params.to_json.to_s
end

Quando(/^o backend receber uma requisição autenticada para alterar a subcategoria "([^"]*)" com os parâmetros$/) do |subcategory_name, params|
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", "Bearer #{@token}"
  
  subcategory = Subcategory.find_by(name: subcategory_name)
  params = JSON.parse(params)
  params['subcategory_id'] = subcategory.id.to_s

  put default_subcategory_path(subcategory), params.to_json.to_s
end

Quando(/^o backend receber uma requisição autenticada para remover a subcategoria "([^"]*)"$/) do |subcategory_name|
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", "Bearer #{@token}"

  subcategory = Subcategory.find_by(name: subcategory_name)

  delete default_subcategory_path(subcategory)
end

Quando(/^o backend receber uma requisição não autenticada para alterar a subcategoria "([^"]*)"$/) do |subcategory_name|
  header "Content-Type", "application/vnd.api+json"

  subcategory = Subcategory.find_by(name: subcategory_name)

  put default_subcategory_path(subcategory)
end

Quando(/^o backend receber uma requisição não autenticada para remover a subcategoria "([^"]*)"$/) do |subcategory_name|
  header "Content-Type", "application/vnd.api+json"

  subcategory = Subcategory.find_by(name: subcategory_name)

  delete default_subcategory_path(subcategory)
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


Então(/^o campo "([^"]*)" da subcategoria deve ser "([^"]*)"$/) do |field, value|
  body = JSON.parse(last_response.body)

  field = case field
  when "nome" 
    "name"
  else raise "field name unknown in step definions"
  end

  expect(body['data']['attributes'][field].to_s).to eq value.to_s
end

Então(/^a subcategoria "([^"]*)" deverá ter sido removida$/) do |subcategory_name|
  expect(Subcategory.find_by(name: subcategory_name)).to be_nil
end