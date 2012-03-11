AMAZON_ID = "AKIAJD3MU5FWQM22BWDA"
AMAZON_SECRET = "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"
AMAZON_ASSOCIATE_ID = "backmybook-20"

# Amazon Web Services information
AWS_ID = "AKIAIBFJRIAKJM22NTVQ"
AWS_SECRET = "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"

ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
      :access_key_id     => AWS_ID,
      :secret_access_key => AWS_SECRET