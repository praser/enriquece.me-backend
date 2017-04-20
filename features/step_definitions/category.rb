Dado(/^a existência das categorais abaixo no sistma:$/) do |table|
	table.hashes.each do |data|
		FactoryGirl.create(:category, {
			name: data['nome'],
			user: User.find_by(email: data['usuario'])
		})
	end
end

Quando(/^o backend receber uma requisição autenticada para alterar a categoria "([^"]*)" com os parâmetros$/) do |category_name, params|
  header "Content-Type", "application/vnd.api+json"
  header "Authorization", "Bearer #{@token}"

  category = Category.find_by(name: category_name)
  put default_category_path(category), params
end

Quando(/^o backend receber uma requisição não autenticada para alterar a categoria "([^"]*)"$/) do |category_name|
  header "Content-Type", "application/vnd.api+json"

  category = Category.find_by(name: category_name)
  put default_category_path(category)
end

Então(/^a categoria "([^"]*)" deve ser cadastrada$/) do |category_name|
	expect(Category.find_by(name: category_name)).to_not be_nil
end

Então(/^a categoria "([^"]*)" deve estar presente na resposta\.$/) do |category_name|
	body = JSON.parse(last_response.body)
	category = Category.find_by(name: category_name)
	expect(body['data']['attributes']['name']).to eq category.name
end