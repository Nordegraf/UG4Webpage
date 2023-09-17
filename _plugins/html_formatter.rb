# custom markdown formatter to allow for html tags inside code blocks
# and automatically allow for switching $HOME and %HOMEPATH% directories
# on the setup page

require 'rouge'

module Rouge
    module Formatters
      # Transforms a token stream into HTML output.
      class UGHTML < Rouge::Formatters::HTML
        TABLE_FOR_ESCAPE_HTML = {
          '&' => '&amp;',
          '<' => '&lt;',
          '>' => '&gt;',
        }.freeze

        tag 'html'

        # @yield the html output.
        def stream(tokens, &b)

            yield "<pre class=\"highlight\"><code>"

            tokens.each do |tok, val|
                yield span(tok, val)
            end

            yield "</code></pre>"

        end

        def span(tok, val)
            return val if escape?(tok)

            safe_span(tok, val)
        end

        def safe_span(tok, safe_val)
            if tok == Token::Tokens::Text
              safe_val.gsub("$HOME", "<div class=\"homepath\">$HOME</div>")
            else
              shortname = tok.shortname or raise "unknown token: #{tok.inspect} for #{safe_val.inspect}"

              "<span class=\"#{shortname}\">#{safe_val}</span>"
            end
          end

      end
    end
  end