# based on https://distresssignal.org/busting-css-cache-with-jekyll-md5-hash
# https://gist.github.com/BryanSchuetz/2ee8c115096d7dd98f294362f6a667db
module Jekyll
  module CacheBust
    class CacheDigester
      require 'digest/md5'

      attr_accessor :file_name, :directory, :additional_content

      def initialize(file_name:, directory: nil, additional_content: nil)
        self.file_name = file_name
        self.directory = directory
        self.additional_content = additional_content
      end

      def digest!
        [file_name, '?', Digest::MD5.hexdigest(file_contents)].join
      end

      private

      def directory_files_content
        source_paths = Array(directory).flat_map do |path|
          File.file?(path) ? [path] : Dir.glob(File.join(path, '**', '*')).select { |entry| File.file?(entry) }
        end
        source_paths = source_paths.uniq.sort
        raise ArgumentError, 'cache digest has no source files' if source_paths.empty?

        source_paths.map { |path| framed(path, File.binread(path)) }.join
      end

      def framed(path, content)
        "#{path.bytesize}:#{path}#{content.bytesize}:#{content}"
      end

      def file_content
        assets_index = file_name.index('assets/')
        raise ArgumentError, "asset URL does not contain assets/: #{file_name}" unless assets_index

        File.binread(file_name.slice(assets_index..-1))
      end

      def file_contents
        content = directory.nil? ? file_content : directory_files_content
        additional_content.nil? ? content : content + framed('additional_content', additional_content.to_s)
      end
    end

    def bust_file_cache(file_name)
      CacheDigester.new(file_name: file_name).digest!
    end

    def bust_css_cache(file_name)
      # main.css is compiled from its Liquid-rendered entrypoint and Sass partials.
      # The old assets/_sass path does not exist, so it emitted MD5(empty).
      config = @context.registers[:site].config
      css_config = [config['max_width'], config['sass']]
      CacheDigester.new(
        file_name: file_name,
        directory: ['assets/css/main.scss', '_sass'],
        additional_content: Marshal.dump(css_config)
      ).digest!
    end
  end
end

Liquid::Template.register_filter(Jekyll::CacheBust)
