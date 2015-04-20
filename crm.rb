
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


get '/contact/:id/edit' do
	id = params[:id]
	@contact = Contact.get(id)
	erb :edit 

end




put "/contact/:id/edit" do
	@contact = Contact.get(params[:id])
    @contact.update({:first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :note => params[:note]})
    redirect to ('/contacts')
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
	contact = Contact.get(params[:id].to_i)
	contact.destroy
	redirect to('/contacts')
end
