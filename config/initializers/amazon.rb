AMAZON_ID = "AKIAJSQQFR3JEQYNKREQ"
AMAZON_SECRET = "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"
AMAZON_ASSOCIATE_ID = "backmybook-20"

# Amazon Web Services information
AWS_ID = "AKIAIBFJRIAKJM22NTVQ"
AWS_SECRET = "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"

ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
      :access_key_id     => AWS_ID,
      :secret_access_key => AWS_SECRET