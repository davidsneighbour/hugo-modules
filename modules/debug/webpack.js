const path = require('path');

class FileListPlugin {
  apply(compiler) {
    compiler.hooks.emit.tapAsync('FileListPlugin', (compilation, callback) => {
      let a = { files: [] };
      for (let filename in compilation.assets) {
        a.files.push(filename);
        let f = filename.split('.');
        let filetype = f[f.length - 1];
        if (filetype === 'css' || filetype === 'js')
          a[filetype] = {
            filename: filename,
            hash: f[f.length - 2]
          };
      }
      const a2 = JSON.stringify(a);
      compilation.assets['filelist.json'] = {
        source: () => { return a2 },
        size: () => { return a2.length }
      };
      callback();
    });
  }
}

module.exports = {
  target: 'web',
  entry: {
    main: path.join(__dirname, 'assets', 'main.js'),
  },
  devtool: 'source-map',
  performance: {
    maxEntrypointSize: 100000,
    maxAssetSize: 500000,
    hints: 'warning'
  },
  plugins: [
    new FileListPlugin(),
  ],
  module: {
    rules: [
      {
        test: /\.(scss|css)$/,
        use: ['style-loader', 'css-loader', 'sass-loader'],
      },
    ],
  },
  mode: "production",
  output: {
    path: path.resolve(__dirname, 'static/assets/js'),
    filename: '[name].[fullhash].js',
    clean: true,
  },
};
