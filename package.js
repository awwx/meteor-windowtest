Package.describe({
  summary: "patch test-in-browser for browser window testing"
})

Package.on_use(function (api) {
  api.use(['jquery', 'spark', 'templating', 'test-in-browser'], 'client');
  api.add_files([
    'windowtest.html',
    'windowtest.js'
  ], 'client');
});
