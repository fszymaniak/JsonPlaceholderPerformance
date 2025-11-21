const path = require('path');

module.exports = {
  mode: 'production',
  entry: {
    'smoke-test': './k6/smoke-test.ts',
    'spike-test': './k6/spike-test.ts',
    'soak-test': './k6/soak-test.ts',
    'stress-test': './k6/stress-test.ts',
    'jsonplaceholder-load-test': './k6/jsonplaceholder-load-test.ts'
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].js',
    libraryTarget: 'commonjs'
  },
  resolve: {
    extensions: ['.ts', '.js']
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/
      }
    ]
  },
  target: 'web',
  externals: /^(k6|https?\:\/\/)(\/.*)?/,
  stats: {
    colors: true
  },
  optimization: {
    minimize: false
  }
};
