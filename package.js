Package.describe({
  name: 'webtempest:disqus',
  version: '0.0.1',
  summary: 'Add disqus to your app',
  git: 'git@github.com:webtempest/meteor-disqus.git',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.0.1');
  api.use('coffeescript');
  api.addFiles([
    'disqus.coffee'
  ], 'client');
});
