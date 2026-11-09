require 'faraday'


prompt = "How do I ask for structured output in this API (gemini)?"

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
    model: "gemini-3.5-flash-lite",
    input: prompt
  }.to_json
end

body = JSON.parse(response.body)
pp(body)
puts

result = body['steps'][1]['content'][0]['text']
puts result

