require 'tmpdir'

# Change your GitHub reponame
GITHUB_REPONAME = "twlevelup/twlevelup.github.io"
SITEMAP_URL = "http://levelup.thoughtworks.com/sitemap.xml"

desc "Generate blog files"
task :generate do
  require 'jekyll'
  Jekyll::Site.new(Jekyll.configuration({
    "source" => ".",
    "destination" => "_site"
  })).process
end


desc "Generate and publish blog to gh-pages"
task :publish => [:generate] do
  Dir.mktmpdir do |tmp|
    cp_r "_site/.", tmp
    Dir.chdir tmp
    system "git init"
    system "git checkout -b master"
    system "git add ."
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m #{message.shellescape}"
    system "git remote add origin https://github.com/#{GITHUB_REPONAME}.git"
    system "git push origin master --force"
    system "curl http://www.google.com/webmasters/sitemaps/ping?sitemap=#{SITEMAP_URL} > /dev/null"
  end
end
