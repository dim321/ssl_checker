module Checker
  class Journal < Grape::API
    desc 'Return journal events.'
    params do
      optional :offset, type: Integer, default: 0
      optional :limit, type: Integer, default: 20
    end
    get :journal do
      ::StatusEvent.order(created_at: :desc).offset(params[:offset]).limit(params[:limit])
    end
  end
end