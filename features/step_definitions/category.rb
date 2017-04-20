Então(/^a categoria "([^"]*)" deve ser cadastrada$/) do |category_name|
  expect(Category.find_by(name: category_name)).to_not be_nil
end

Então(/^a categoria "([^"]*)" deve estar presente na resposta\.$/) do |category_name|
  body = JSON.parse(last_response.body)
  category = Category.find_by(name: category_name)
  expect(body['data']['attributes']['name']).to eq category.name
end