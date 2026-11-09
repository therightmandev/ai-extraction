require 'faraday'


prompt = '''Hello there'''

conn = Faraday.new(
  url: "https://generativelanguage.googleapis.com",
  headers: {
    "x-goog-api-key" => ENV["GEMINI_API_KEY"],
    "Content-Type" => "application/json",
    "Api-Revision" => "2026-05-20"
  }
)


response = conn.post("/v1beta/interactions") do |req|
  req.body = {
    model: "gemini-3.8-flash",
    input: "Explain how AI works in a few words"
  }.to_json
  puts 'req', req.inspect
end

puts response.success?
puts response.body

