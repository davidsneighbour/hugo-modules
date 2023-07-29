// @todo document
import fetch from 'node-fetch';
import 'dotenv/config';
import fs from 'fs';

const { RELEASE_GIST } = process.env;
const RELEASE_GIST_URL = `https://api.github.com/gists/${RELEASE_GIST}`;

fetch(RELEASE_GIST_URL)
  .then((response) => response.text())
  .then((data) => {

    // parse gist into JSON object
    const gist = JSON.parse(data);

    // create release hooks
    for (const fileName in gist.files) {
      const fileContent = gist.files[fileName].content;
      const fileNameFull = 'bin/release/' + fileName;
      fs.writeFileSync(fileNameFull, fileContent);
      console.log(`Updated ${fileNameFull}`);

      // create the hook in each module
      const dir = fs.opendirSync('modules');
      let dirent;
      while ((dirent = dir.readSync()) !== null) {
        const fileNameFull1 = 'modules/' + dirent.name + '/bin/release/' + fileName;
        fs.writeFileSync(fileNameFull1, fileContent);
        console.log(`Updated ${fileNameFull1}`);
      }
    }
  });
