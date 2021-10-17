require 'colorize'
require 'json'
require 'open-uri'

credentials = JSON.parse(File.open("credentials.json", "r").read)
bearer_token = credentials['bearer_token']
instance = credentials['instance']
limit = File.open("limit", "r").read.to_f

begin
  pretty_price = JSON.parse(URI.open("https://api.coindesk.com/v1/bpi/currentprice.json").read)['bpi']['USD']['rate']
  current_price = pretty_price.gsub(",", "").to_f

  if current_price > limit
    puts "BitCoin went " + "▲".green + " to " + current_price.yellow + "!"
    limit = current_price

    f = File.open("limit", "w")
    f.write(limit.to_s)
    f.close
     uri = URI.parse("https://#{instance}/api/v1/statuses")
     header = {
       'Authorization'=> "Bearer #{bearer_token}",
       'Content-Type' => 'application/json'
     }

    req = Net::HTTP::Post.new(uri.request_uri, header)
    req.body = {
       'status'       => "BitCoin reached its highest price ever at $#{pretty_price}!! 🚀🚀",
       'source'       => 'btclimitbreak',
       'visibility'   => 'public',
       'content_type' => 'text/html'
    }.to_json

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    res = http.request(req)
  elsif current_price < limit
    puts "BitCoin went " + "▼".red + " to #{current_price.yellow} from its highest price of #{limit.yellow}!"
  end
rescue e
 puts "Blue up with type #{e.class.red} and message #{e.message.red}"
end
