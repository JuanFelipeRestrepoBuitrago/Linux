# Managing Node.js Versions with nvm (Node Version Manager)

## Installation of nvm
- Install `nvm` by following the instructions on the [nvm GitHub page](https://github.com/nvm-sh/nvm).

## Installing Node.js versions
- Use `nvm install <version>` to install the desired Node.js version, e.g., `nvm install 14.17.0`.
```bash
nvm install <version>
```

## Setting the default Node.js version
- Set the default Node.js version with `nvm alias default <version>`, e.g., `nvm alias default 14.17.0`.
```bash
nvm alias default <version>
```

## Using a specific Node.js version
- Use a specific Node.js version in the current shell session with `nvm use <version>`, e.g., `nvm use 14.17.0`.
```bash
nvm use <version>
```

## Listing installed Node.js versions
- List all installed Node.js versions with `nvm ls`.
```bash
nvm ls
```

## Listing available Node.js versions
- List all available Node.js versions with `nvm ls-remote`.
```bash
nvm ls-remote
```

## Setting Node.js version for a project
- Create a `.nvmrc` file in your project directory with the desired Node.js version number, e.g., `14.17.0`.
```bash
echo "<version>" > .nvmrc
```
- Use `nvm use` in your project directory to automatically switch to the specified Node.js version.
```bash
nvm use
```

## Setting Node.js version for a project

To specify a Node.js version for a specific project, you can use a `.nvmrc` file. This file tells nvm which Node.js version to use when you navigate to the project directory in your terminal.

### Steps to set the Node.js version for a project:

1. **Create a `.nvmrc` file**:
   - In your project's root directory, create a file named `.nvmrc`.

2. **Specify the Node.js version**:
   - In the `.nvmrc` file, write the desired Node.js version number, e.g., `14.17.0`.

3. **Use the Node.js version**:
   - Navigate to your project directory in the terminal.

4. **Activate the specified Node.js version**:
   - Run `nvm use` in the project directory.
   - This command reads the `.nvmrc` file and switches to the specified Node.js version automatically.

### Example:

Suppose your `.nvmrc` file contains `14.17.0`. After navigating to your project directory, running `nvm use` will switch your Node.js version to `14.17.0` for that project.

### Benefits:

- Using a `.nvmrc` file ensures that everyone working on the project uses the same Node.js version.
- It makes it easier to switch between Node.js versions for different projects.

## Using nvm with npm
- After switching Node.js versions with nvm, use `npm` as usual to manage your project's dependencies.

Using nvm allows you to manage multiple Node.js versions on your system and easily switch between them for different projects.
