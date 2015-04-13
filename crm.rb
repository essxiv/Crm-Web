
require 'sinatra'
require 'data_mapper'


DataMapper.setup(:default, "sqlite3:database.sqlite3")


class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String
end


DataMapper.finalize
DataMapper.auto_upgrade!


get '/contacts/:id/edit' do
	id = params[:id].to_i
	@contact = Contact.get(id)
	erb :edit 

end




put "/contacts/:id/edit" do
	@contact = Contact.get(params[:id])
	if contact
		@contact.firstname = params[:first_name]
		@contact.lastname = params[:last_name]
		@contact.email = params[:email]
		@conact.note = note[:note]
		@contact.save
		redirect to ("/contacts")
	else
		puts "this is an error"
	end
end


get '/' do
	@crm_app_name = "+1. +2. +3. +4. +5."
	erb :index
end

get '/contacts' do
  	erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end


post '/contacts' do
	puts params
  	new_contact = Contact.create({:first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :note => params[:note]})
 	redirect to('/contacts')
end

delete '/contacts/:id/delete' do
	contact = Contact.get(params[:id])
	contact.destroy
	redirect to('/contacts')
end
