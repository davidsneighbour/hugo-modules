// @todo document
import fetch from 'node-fetch';
import 'dotenv/config';
import fs from 'fs';
import path from 'path';

const { RELEASE_GIST } = process.env;
const RELEASE_GIST_URL = `https://api.github.com/gists/${RELEASE_GIST}`;

fetch(RELEASE_GIST_URL)
  .then((response) => response.text())
  .then((data) => {

    // parse gist into JSON object
    const gist = JSON.parse(data);

    // create release hooks
    for (const fileName in gist.files) {
      if (path.extname(fileName) === '.md') {
        continue;
      }
      const fileContent = gist.files[fileName].content;

      // create the hook in each module
      const dir = fs.opendirSync('modules');
      let dirent;
      try {
        while ((dirent = dir.readSync()) !== null) {
          if (dirent.name !== '.gitignore') {
            const fileNameFull1 = `modules/${dirent.name}/bin/release/${fileName}`;
            fs.writeFileSync(fileNameFull1, fileContent);
            console.log(`Updated ${fileNameFull1}`);
          }
        }
      } finally {
        dir.closeSync(); // Explicitly close the directory handle
      }
    }
  })
  .catch((error) => {
    console.error('Error fetching or processing the gist:', error);
  });
