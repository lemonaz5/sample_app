module Twitter
  class Users < Grape::API
    resource :users do
      get do
        User.all
      end

      #http://localhost:3000/api/v1/user/show
      desc 'Return users'
      get :show do
        User.limit(10)
      end

      #http://localhost:3000/api/v1/user/microposts
      desc 'Return a personal micropost'
      get :microposts do
        authenticate!
        current_user.microposts.limit(10)
      end

      # http://localhost:3000/api/v1/user/1
      desc 'Return a user'
      params do
        requires :id, type: Integer, desc: 'User id.'
      end
      route_param :id do
        get do
          User.find(params[:id])
        end
      end

      desc 'Create a micropost'
      params do
        requires :content, type: String, desc: 'a new post'
      end
      post do
        authenticate!
        micropost = Micropost.create({
          user: current_user,
          content: params[:content]
        })

        present micropost, with: Entities::Micropost
      end

      desc 'Update a user.'
      params do
        requires :id, type: String, desc: 'Status ID.'
        requires :micropost, type: String, desc: 'Your status.'
      end
      put ':id' do
        authenticate!
        current_user.microposts.find(params[:id]).update({
          user: current_user,
          text: params[:status]
        })
      end

      desc 'Delete a status.'
      params do
        requires :id, type: String, desc: 'Status ID.'
      end
      delete ':id' do
        authenticate!
        current_user.statuses.find(params[:id]).destroy
      end
    end
  end
end

