const fs = require('fs')
const DateGenerator = require('random-date-generator');
const { readdir, stat } = require("fs").promises
const { join } = require("path")
const dirs = async (path = "content/posts/") => (await stat(path)).isDirectory()
  ? Promise.all((await readdir(path))
    .map(p => dirs(join(path, p)))
  ).then(results =>
    [].concat(path, ...results)
  )
  : [];

dirs("content/posts/").then(function (elements) {
  elements.forEach(function (value) {
    if (value !== "content/posts/") {
      fs.readFile((value + '/index.md'), 'utf8', function (err, data) {
        if (err) {
          return console.log(err);
        }
        const startDate = new Date();
        startDate.setFullYear(startDate.getFullYear() - 9);

        const endDate = new Date();
        const date = DateGenerator.getRandomDateInRange(startDate, endDate).toISOString().replace(/\..+/, '')
        const result = data.replace(/date: (.*)/g, 'date: ' + date);
        fs.writeFile((value + '/index.md'), result, 'utf8', function (err) {
          if (err) return console.log(err);
        });
      });
    }
  });
}, console.error)
