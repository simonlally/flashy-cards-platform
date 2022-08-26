module Auth
    def decode(payload)
      JWT.decode(payload, ENV["JWT_SECRET_KEY"]).first
    end
  
    def encode(payload)
      JWT.encode(payload, ENV["JWT_SECRET_KEY"])
    end
  
    def auth_present?
      request.headers["Authorization"]
    end
  end
  