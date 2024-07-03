require "find"
require "fileutils"

EXCLUDE_DIRS = %w[log tmp storage config/credentials .git .ruby-lsp].freeze
EXCLUDE_FILES = %w[.env credentials.yml.enc master.key condense_app.rb].freeze

OUTPUT_FILE = "condensed_app.txt"

def exclude_path?(path)
  EXCLUDE_DIRS.any? { |dir| path.include?("/#{dir}/") } || EXCLUDE_FILES.any? { |file| path.end_with?(file) }
end

def concatenate_files(root_dir)
  concatenated_content = ""

  Find.find(root_dir) do |path|
    if File.directory?(path)
      if EXCLUDE_DIRS.any? { |dir| path == File.join(root_dir, dir) }
        Find.prune
      end
    else
      unless exclude_path?(path)
        file_content = File.read(path)
        concatenated_content << "### FILE: #{path} ###\n"
        concatenated_content << file_content
        concatenated_content << "\n\n"
      end
    end
  end

  concatenated_content
end

def write_to_output_file(content)
  FileUtils.rm_f(OUTPUT_FILE)
  File.open(OUTPUT_FILE, "w") do |file|
    file.write(content)
  end
end

root_dir = ARGV[0] || "."
concatenated_content = concatenate_files(File.expand_path(root_dir))
write_to_output_file(concatenated_content)

puts "Condensed content written to #{OUTPUT_FILE}"
