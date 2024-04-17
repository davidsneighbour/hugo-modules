import path from 'path';
import { fileURLToPath } from 'url';

// reminder: __dirname is not available in ESM
const __dirname = path.dirname(fileURLToPath(import.meta.url));

class FileListPlugin {
  apply(compiler) {
    compiler.hooks.emit.tapAsync('FileListPlugin', (compilation, callback) => {
      let a = { files: [] };

      for (let filename in compilation.assets) {
        a.files.push(filename);
        let f = filename.split('.');
        let filetype = f[f.length - 1];
        if (filetype === 'css' || filetype === 'js') {
          a[filetype] = {
            filename: filename,
            hash: f[f.length - 2]
          };
        }
      }

      const a2 = JSON.stringify(a);
      compilation.assets['filelist.json'] = {
        source: () => a2,
        size: () => a2.length
      };
      callback();
    });
  }
}

const config = {
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
  optimization: {
    nodeEnv: 'production',
    minimize: true,
    splitChunks: {
      chunks: 'all',
    },
  },
};

export default config;
