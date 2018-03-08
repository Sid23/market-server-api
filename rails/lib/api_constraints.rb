class ApiConstraints

    # Initialize variables using options hash
    def initialize(options)
        @version = options[:version]
        # Indicate if this version is the default ones
        @default = options[:default]
    end
  
    # Method triggered by the router, in order to check if default API version is required (if yes does not matter about version number)
    # It is also ok if 'Accept' header match the given string
    def matches?(req)
        @default || req.headers['Accept'].include?("application/marketplace.v#{@version}")
    end
end