class UserSerializer < ActiveModel::Serializer
 attributes :id, :username, :role_id, :email
end
