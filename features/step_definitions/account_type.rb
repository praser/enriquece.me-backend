Dado(/^a existência dos tipos de conta abaixo no sistema:$/) do |table|
  table.hashes.each do |data|
  	FactoryGirl.create(:account_type, {name: data['nome']})
  end
end