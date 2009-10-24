DataMapper.setup(:default, 
  :adapter=>'sqlite3', 
  :database=>File.join(File.dirname(__FILE__), 'test.db')
)

class User 
  include DataMapper::Resource
  property :id, Serial
  property :first_name, String,:length=>255,:nullable=>false
  property :last_name, String, :length=>255,:nullable=>false
  property :email, String, :length=>255,:nullable=>false
  property :username, String, :length=>255
  property :admin, Boolean, :default=>false
  
  has n, :posts, :child_key => [:author_id]
  
  #make test suite happy
  def new_record?
    new?
  end
end

class Business 
  include DataMapper::Resource
  property :id, Serial
  property :name, String,:length=>255,:nullable=>false

  belongs_to :owner, :model => 'User',:nullable=>false
  
  #make test suite happy
  def new_record?
    new?
  end
end

class Post
  include DataMapper::Resource
  property :id, Serial
  property :name, String,:length=>255,:nullable=>false
  
  belongs_to :author, :model => 'User', :nullable=>false 
  
  #make test suite happy
  def new_record?
    new?
  end
end

DataMapper.auto_migrate!