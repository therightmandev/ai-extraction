require 'faraday'


prompt = "How do I ask for structured output in this API (gemini)? But in ruby with faraday. concise answer, please."

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
    input: prompt,
    response_format: {
      type: "text",
      mime_type: "application/json",
      schema: {
        type: "object",
        properties: {
          "question": {
            "type": "string",
            "description": "The question rephrased using only 3 words",
          },
          "answer": {
            "type": "string",
            "description": "An answer to the question using only 5 words",
          },
        },
      },
    },
  }.to_json
end

body = JSON.parse(response.body)
pp(body)
puts

result = body['steps'][1]['content'][0]['text']
puts result

