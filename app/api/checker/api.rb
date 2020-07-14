module Checker
    class API < Grape::API
    version 'v1', using: :header, vendor: 'ssl_checker'
    format :json
    prefix :api

    resource :domains do

      desc 'Return all domains with statuses.'
      params do
        optional :offset, type: Integer, default: 0
        optional :limit, type: Integer, default: 20
      end
      get :status do
        Domain.offset(:offset).limit(:limit)
      end

      desc 'Add new domain into database'
      params do
        requires :name, type: String, desc: 'New domain hostname'
        optional :status, type: Boolean, default: false, desc 'Domain status'
      end
      post :domain do
        Domain.create!({
          name: params[:name],
          status: params[:status]
        })
      end
    end #end :domains resource

    resource :status_events do

      desc 'Return journal events.'
      params do
        optional :offset, type: Integer, default: 0
        optional :limit, type: Integer, default: 20
      end
      get :journal do
        StatusEvent.order(:created_at desc).offset(params[:offset]).limit(params[:limit])
      end
    end
end