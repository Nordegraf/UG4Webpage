require 'uri'


module Lua
    class LuaPage < Jekyll::Page

      include Jekyll::Filters

      # Regex to match the title inside the lua tutorial header
      # the title is found in the first comment block with the \title
      # tag
      TITLE_REGEXP = /title\s*(.*)\s*\-\-/.freeze

      # regex to find the brief description of the tutorial
      # found in the first comment block with the \brief tag
      BRIEF_REGEXP = /\\brief\s*([\s\S]+?)--\n/.freeze

      # sections are are marked with a line of at least 6 dashes in front and behind
      SECTION_REGEXP = /-{6,}\n\s*(.*)\n-{6,}\n/.freeze

      # comments are marked with two dashes and a space in front
      COMMENT_REGEXP = /(^--\s{1,})/m.freeze

      # no () allowed in urls, otherwise finding enclosed urls is difficult
      URL_REGEXP = /((http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/[^)\n\s]*)?)/ix.freeze

      def initialize(site, base, dir, entry, type, collection = nil)
        @site = site
        @base = base
        @dir  = dir
        @source = entry
        @type = type

        @excerpt = nil

        @ext = ".html"
        @basename = entry[3..-(@ext.length)]
        @name = @basename + @ext

        self.content = read_file(@base + "/" + entry)
        code = self.content

        # regex to find title and brief description
        @title = get_title()
        @brief = get_brief()
        @number = entry[3..4]

        @converter = @site.converters.find { |c| c.instance_of?(Jekyll::Converters::Markdown) }

        highlight_code()
        attach_code(code)

        @data = {
          'layout' => 'title',
          'title' => @type + ' ' + @number + ' - ' + @title,
          'brief' => @brief,
          'category' => collection,
          'number' => @number
        }
      end

      def url_placeholders
        {
          :path       => @dir,
          :category   => 'lua_tutorials',
          :basename   => basename,
          :output_ext => output_ext,
        }
      end

      def get_title()
        if self.content =~ TITLE_REGEXP
          return $1
        else
          Jekyll.logger.warn "", "No title found for #{@source}"
          return "No title found"
        end
      end

      def get_brief()
        match = self.content.match(BRIEF_REGEXP)

        if match
          # remove comment tags
          brief = match[1].gsub(/\n--\s*/, " ")
          self.content = match.post_match
          return brief
        else
          Jekyll.logger.warn "", "No brief description found for #{@source}"
          return "No brief description found"
        end
      end

      def replace_sections(content)
        return content.gsub(SECTION_REGEXP, "#### \\1\n")
      end

      def remove_lines(content)
        return content.gsub(/-{5,}/m, "")
      end

      def replace_urls(content)
        return content.gsub(URL_REGEXP, "<a href=\"\\1\">\\1</a>")
      end

      def highlight_specific(content)
        # specific highlighting for lua code snippets in comments
        # highlighted are .., nil, print, --
        return content.gsub(/(nil|\.\.|--)/, "<code>\\1</code>")
      end

      def convert_block(content)
        content = replace_sections(content)
        content = remove_lines(content)
        content = replace_urls(content)
        content = highlight_specific(content)

        content = @converter.convert(content)
        return content
      end

      def highlight_code()
        converter = @site.converters.find { |c| c.instance_of?(Jekyll::Converters::Markdown) }
        comment = false
        highlight = false

        new_content = ""

        commentblock = ""

        self.content.each_line do |line|
          if !line.start_with?("--[[") && line.start_with?("--")
            comment = true

            if highlight
              highlight = false
              new_content += "{% endhighlight %}\n"
            end

            if line == "--\n"
              new_content += convert_block(commentblock)
              commentblock = ""
              next
            end

            line = line.gsub(COMMENT_REGEXP, "")

            commentblock += line
            next

          else
            if !highlight
              highlight = true
              line = "{% highlight lua %}\n" + line
            end

            if comment
              comment = false

              new_content += convert_block(commentblock)
              commentblock = ""
            end

          end
          new_content += line
        end

        if highlight
          new_content += "{% endhighlight %}\n"
        end
        self.content = new_content
      end

      def attach_code(code)
        self.content += @converter.convert("\n\n### Complete Code\n\n")
        self.content += "{% highlight lua %}\n"
        self.content += code
        self.content += "{% endhighlight %}\n"
      end

      def read_file(filename)
        return File.read(filename, **Jekyll::Utils.merged_file_read_opts(site, {}))
      end
    end



    class LuaReader
      def initialize(site, collection, dir, location, type)
        @site = site
        @base = site.source
        @dir  = dir
        @pages = {}
        @location = location
        @collection = collection
        @type = type

        site.collections[collection] = Jekyll::Collection.new(site, collection)
      end

      def read()
        entries = Dir.chdir(@base + @dir) do
          Dir["*.{lua}"].select { |fn| File.directory?(fn) }
        end

        @pages = entries.map do |entry|
          newpage = LuaPage.new(@site, @base + @dir, @location, entry, @type, @collection)
          @site.collections[@collection].docs << newpage
        end
      end
    end



    class Generator < Jekyll::Generator
      def generate(site)
        Jekyll.logger.info "lua Tutorials:", "Generating pages for lua tutorials"

        reader = LuaReader.new(site, "lua_tutorials", "/_lua_tutorials", "/tutorials/lua", "Tutorial")
        reader.read()

        Jekyll.logger.info "lua Examples:", "Generating pages for lua examples"

        reader = LuaReader.new(site, "lua_examples", "/_lua_examples", "/examples/lua", "Example")
        reader.read()
      end
    end
end