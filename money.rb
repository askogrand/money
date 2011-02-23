require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'

DataMapper::setup(:default, "sqlite://#{Dir.pwd}/money.db")

#Models

class Transaction
  
  include DataMapper::Resource
  
  property :id,           Serial
  property :source_id,    Integer
  property :target_id,    Integer
  property :amount,       Decimal, :precision => 10, :scale => 2
  property :title,        String
  property :description,  Text
  property :is_paid,      Boolean
  property :created_at,   DateTime
  property :updated_at,   DateTime
  
  belongs_to :source, 'User', :key => true
  belongs_to :target, 'User', :key => true

end

class User
  
  include DataMapper::Resource
  
  property :id,           Serial
  property :name,         String
  property :email,        String
  
  has n, :transactions, :child_key => [ :source_id ]
  has n, :transactions, :child_key => [ :target_id ]

end

#Build, update

DataMapper.finalize
DataMapper.auto_upgrade!

#Functions

def getTotal(you, them)
  
end

def payDebts(date)
  
end

#Routes

before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  'Welcome to money'
end

get '/list' do
  @bills = Transaction.all(:source_id => 1)
  @users = User.all();
  erb :list
end

get '/payDebt/:id' do
  bill = Transaction.get(params[:id])
  bill.update(:isPaid => 1;
  redirect('/list')
end