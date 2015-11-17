class BaseMailer < ActionMailer::Base
  NOREPLY_EMAIL = "no-reply@pustovalov.net"
  default from: NOREPLY_EMAIL
end
