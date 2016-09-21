module Validify
  module InstanceMethods
    def params_blank?(params)
      return true if params.has_value?("") || params.has_value?(nil)
    end
  end
end
