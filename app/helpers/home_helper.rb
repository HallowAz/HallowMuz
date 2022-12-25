module HomeHelper
    def self.my_muz(lib)
      lib_muz = lib.map do |index|
        Song.find_by(id:index)
      end
      lib_muz
    end

    def self.search_muz(str)
      search_muz = Song.all.select {|song| song[:name].downcase.include?(str)}
    end

    def self.save_file(song)
      File.open(Rails.root.join('public', 'music', song.original_filename.gsub(' ', '_')), 'wb') do |file|
        file.write(song.read)
      end
    end
end

