require 'anemone'
require 'pp'
require 'nokogiri'
require_relative 'modules/logable'
require_relative 'modules/validateable'
require_relative 'word_counter'

class SpeedCounter
  include Logable
  include Validateable
  def initialize(url)
    @url = url
    @crawl_pages = 200
    @word_counter = WordCounter.new
    @text_selector_blog_view = '//div[@id=\'content-left\']//div/text()'
    @text_selector_post_view = '//div[@id=\'content-left\']//p/text()'
    Logable::set_log_file url
  end

  def finish
    @word_counter.write
    # Because anemone is multithreaded and I'm not into playing with it's own threads
    # the "best" way to exit is with this very blunt knife of a Kernel.exit! exclamation is necessary
    Kernel.exit! false
  end

  def run
    count = 0
    Anemone.crawl(@url) do |anemone|
      anemone.skip_links_like %r{^/profiles/|.*replytocom.*|2013|2012}
      anemone.on_every_page do |page|

        begin
          puts page.url
          Logable::log(page.url)
          if !is_valid page
            next
          end
          clean_content = page.doc.xpath(@text_selector_blog_view).to_s
          clean_content += page.doc.xpath(@text_selector_post_view).to_s

          @word_counter.count(clean_content)

          if  count > @crawl_pages
            puts 'Finishing'
            finish
          end

          count += 1
        rescue Exception=>ex
          puts ex
          Logable::log(ex)
          next
        end
      end
    end
  end
end
