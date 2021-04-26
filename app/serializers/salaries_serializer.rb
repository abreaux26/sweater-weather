class SalariesSerializer
  include FastJsonapi::ObjectSerializer
  set_id nil
  attributes :destination, :forecast, :salaries
end
