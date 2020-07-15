class API < Grape::API
  prefix 'api'
  format :json
  mount Checker::Status
  mount Checker::Domain
  mount Checker::Journal
end