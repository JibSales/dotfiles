module.exports = {
  ignorePatterns: ['dist', 'build', 'node_modules', '.eslintrc.js', 'jest.config.js'],
  extends: [
    'plugin:@typescript-eslint/recommended',
    'airbnb-typescript/base',
    'prettier',
    'plugin:prettier/recommended',
  ],
  env: {
    node: true,
  },
  parserOptions: {
    project: 'tsconfig.json',
    tsconfigRootDir: __dirname,
    sourceType: 'module',
    ecmaVersion: 6,
  },
  rules: {
    'max-len': ['error', 120, 2],
    'import/prefer-default-export': 'off',
  },
};
