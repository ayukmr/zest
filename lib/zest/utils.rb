# builtin strings
class String
  # color string
  def black;   "\e[30m#{self}\e[0m" end
  def red;     "\e[31m#{self}\e[0m" end
  def green;   "\e[32m#{self}\e[0m" end
  def yellow;  "\e[33m#{self}\e[0m" end
  def blue;    "\e[34m#{self}\e[0m" end
  def magenta; "\e[35m#{self}\e[0m" end
  def cyan;    "\e[36m#{self}\e[0m" end

  # format string
  def bold;      "\e[1m#{self}\e[22m" end
  def italic;    "\e[3m#{self}\e[23m" end
  def underline; "\e[4m#{self}\e[24m" end

  # convert home into tilde
  def tilde
    sub(Regexp.new(
      "^#{Regexp.escape(Dir.home)}"
    ), '~')
  end
end

# raise error
def error(message, exit_code = nil)
  puts "#{'error'.red.bold}: #{message}"
  exit exit_code if exit_code
end

# run a block with key if key exists
def hash_do(hash, key, &block)
  hash[key].each { |arr| block.call(arr) } if hash.key?(key)
end

# check if file exists
def exists?(file)
  File.file?(file) || File.symlink?(file)
end

# coalesce nil expressions
def coalesce(expression, substitute)
  expression || substitute
end

# get config path
def config_path
  Pathname(File.expand_path('.')).ascend do |dir|
    return dir if exists?(File.join(dir, '.zest.yml'))
  end

  error '.zest.yml not found', 1
end

# get config glob path
def glob_path
  config = Zest::Config.new
  File.join(config_path, '*', config.bootstrap_file)
end

# remove file if it exists
def remove_file(src, dest)
  config = Zest::Config.new
  dir_file = File.join(dest, File.basename(src))

  if exists?(dest)
    status("deleting #{dest.tilde}") do
      File.delete(dest)
    end
  end

  # remove file is dir is provided
  return unless config.force? && exists?(dir_file)

  status("deleting #{dir_file.tilde}") do
    File.delete(dir_file)
  end
end

# traverse hash keys
def traverse(hash, *keys)
  keys.each do |key|
    return nil unless hash.key?(key)
    hash = hash[key]
  end

  hash
end
