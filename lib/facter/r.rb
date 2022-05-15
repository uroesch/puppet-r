# Find the version of R installed on the system
# If R is not installed the value is set to none.

class RVersion
  @key_translation = {
    'svn rev'        => 'svn_rev',
    'version.string' => 'string'
  }

  @fact = {
    'platform' => 'none',
    'arch'     => 'none',
    'os'       => 'none',
    'system'   => 'none',
    'status'   => 'none',
    'major'    => 'none',
    'minor'    => 'none',
    'year'     => 'none',
    'month'    => 'none',
    'day'      => 'none',
    'svn_rev'  => 'none',
    'language' => 'none',
    'string'   => 'none',
    'nickname' => 'none',
    'version'  => 'none'
  }

  def self.exec
    cmd = 'echo R.version | Rscript /dev/stdin'
    begin
      result = Facter::Core::Execution.execute(cmd)
      adjust_keys(result)
    rescue
      ''
    end
  end

  def self.adjust_keys(input)
    @key_translation.each do |key, replace|
      input.gsub!(%r{^#{key}}, replace)
    end
    input
  end

  def self.parse
    result = exec.split("\n")
    result.each do |line|
      next unless line =~ %r{^[a-z]}i
      key, value = line.split(%r{\s+}, 2)
      @fact[key] = value.strip
    end
    @fact
  end

  def self.version
    return if @fact['major'].to_i == 0
    @fact['version'] = @fact.slice('major', 'minor').values.join('.')
  end

  def self.fact
    parse
    version
    @fact
  end
end

Facter.add('r') do
  setcode do
    RVersion.fact
  end
end
