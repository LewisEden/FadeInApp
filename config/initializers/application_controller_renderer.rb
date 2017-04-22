# Be sure to restart your server when you modify this file.

# ApplicationController.renderer.defaults.merge!(
#   http_host: 'example.org',
#   https: false
# )

Paperclip::Attachment.default_options[:s3_protocol] = "https"
