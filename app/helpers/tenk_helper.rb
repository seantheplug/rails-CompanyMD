module TenkHelper
require 'rest-client'

def set_10k(ticker)
  tenk = []
  url = 'https://api.sec-api.io'
  body = { "query": {
            "query_string": { "query": "ticker: #{ticker} AND formType:\"10-K\"" } },
            "from": "0",
            "size": "10",
            "sort": [{ "filedAt": { "order": "desc" } }] }

  json_body = body.to_json

  res = RestClient.post url, json_body, {content_type: :json, accept: :json}
  data = JSON.parse(res.body)
  data["filings"].each do |package|
    tenk << { link: package["linkToHtml"], date: package["filedAt"] }
    end

  raise
end
end
