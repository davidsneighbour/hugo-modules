const defaultStandardVersion = require('@davidsneighbour/release-config');
const localStandardVersion = {
  skip: {
    changelog: true
  }
};
const standardVersion = {
  ...defaultStandardVersion,
  ...localStandardVersion,
};
module.exports = standardVersion;
