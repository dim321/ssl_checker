module Checker
  class Status < Grape::API
    desc 'Return all domains with statuses.'
    #Параметры для пажинации - смещение и количество записей на странице
    params do
      optional :offset, type: Integer, default: 0
      optional :limit, type: Integer, default: 20
    end
    get :status do
      ::Domain.offset(params[:offset]).limit(params[:limit])
    end
  end
end