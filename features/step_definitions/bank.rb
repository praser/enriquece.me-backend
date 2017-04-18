Dado(/^a existência das instituições financeiras abaixo no sistema:$/) do |table|
	table.hashes.each do |data|
		FactoryGirl.create(:bank,{
			name: data['nome'],
			code: data['código']
		})
	end
end