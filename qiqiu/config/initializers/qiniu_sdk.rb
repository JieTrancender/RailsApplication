#!/usr/bin/env ruby
# encoding: utf-8

require 'qiniu'

Qiniu.establish_connection! :access_key => '3Qtork7ifbgTZ9tWPuNGULubJN0KOXbRwHZ33Txr',
    :secret_key => 'TG5dfKXaXy-3uKYEEsW51x8SYLJ9H-5A8IWOxs7I'

Rails.application.config.qiniu_domain = 'jie-trancender.org'
