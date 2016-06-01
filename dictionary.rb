require 'rack'

class Dictionary

  def self.call(env)
    request = Rack::Request.new(env)

    if request.params.length == 0
      output = "Welcome to Dictionary"
    else
      dictionary = open("dictionary.txt"){|f| f.read }
      word = request["word"].downcase
      found = false
      output = ''
      dictionary.each_line do |line|
        line.strip!
        if line.downcase.start_with?(word)
          found = true
          output = line
          break
        end
      end
      output = "Word not found" unless found
    end
    [200, {"Content-Type" => "text/html"}, ["#{output}"]]
  end

end

Rack::Handler::WEBrick.run Dictionary
