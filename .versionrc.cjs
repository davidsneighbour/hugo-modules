const defaultStandardVersion = require('@davidsneighbour/release-config');
module.exports = {
  ...defaultStandardVersion,
  skip: {
    changelog: true
  },
  types: [
    { type: "modules", section: "Modules" },
    ...defaultStandardVersion.types,
  ],
};
