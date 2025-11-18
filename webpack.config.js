const path = require('path');

module.exports = {
  mode: 'production',
  entry: {
    'smoke-test': './src/smoke-test.ts',
    'spike-test': './src/spike-test.ts',
    'soak-test': './src/soak-test.ts',
    'stress-test': './src/stress-test.ts',
    'jsonplaceholder-load-test': './src/jsonplaceholder-load-test.ts'
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
