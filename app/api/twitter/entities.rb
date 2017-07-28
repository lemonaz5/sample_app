module Twitter
  module Entities
    class User < Grape::Entity
      expose :id, if: { type: :full }
      expose :name
      expose :email
      expose :created_at
    end

    class Type < Grape::Entity
      # expose(:type){|x, opts| opts[:type] }
      expose(:type){|x| x.admin? ? :admin : :member }
    end

    class Micropost < Grape::Entity
      expose :id
      expose :content
      expose :user, using: User
    end
  end
end
