module.exports = {
  'extends': 'airbnb',
  'parser': 'babel-eslint',
  'plugins': [
    'react',
    'jsx-a11y',
    'import',
  ],
  'rules': {
    'import/prefer-default-export': 'off',
    'react/require-default-props': 'off',
    'jsx-a11y/no-noninteractive-element-interactions': 'off',
    'no-case-declarations': 'off',
  },
  'env': {
    'browser': true,
    'node': true,
    'jest': true,
  },
};
