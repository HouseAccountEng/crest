require_relative 'lib/crest/version'

Gem::Specification.new do |spec|
  spec.name        = 'crest'
  spec.version     = Crest::VERSION
  spec.authors     = [ 'Claudio Baccigalupo' ]
  spec.email       = [ 'claudiob@users.noreply.github.com' ]
  spec.homepage    = 'https://github.com/claudiob/crest'
  spec.summary     = 'Hand out a contact card your app is saved under'
  spec.description = 'Answers a .vcf route with the vCard a phone offers to save'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/claudiob/crest/'
  spec.metadata['changelog_uri']     = 'https://github.com/claudiob/crest/blob/main/CHANGELOG.md'
  spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/crest'
  spec.required_ruby_version         = '>= 3'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['lib/**/*', 'CHANGELOG.md', 'LICENSE.txt', 'README.md']
  end
end
