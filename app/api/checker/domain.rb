module Checker
  class Domain < Grape::API
    desc 'Add new domain into database'
    params do
      requires :name, type: String, desc: 'New domain hostname'
      optional :status, type: Boolean, default: false, desc: 'Domain status'
    end
    post :domain do
      ::Domain.create!({
        name: params[:name],
        status: params[:status]
      })
    end
  end
end
