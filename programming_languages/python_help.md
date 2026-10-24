# Managing Python Versions with pyenv on Linux

## Installation of pyenv
- Install `pyenv` using your package manager or by following the instructions on the [pyenv GitHub page](https://github.com/pyenv/pyenv).

### Personal Instalation

1. Run the following command to install `pyenv` dependencies:
```bash
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses-dev \
xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
```
2. Install `pyenv` by running the following commands:
```bash
curl https://pyenv.run | bash
```
3. Load `pyenv` into your shell by copying the following lines into your `~/.bashrc`, `~/.bash_profile`, or `~/.zshrc` file:
```bash
# Python Package Manager
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```
```bash
# Command to add lines to file .zshrc
echo '# Python Package Manager' >> ~/.zshrc && echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc && echo 'eval "$(pyenv init --path)"' >> ~/.zshrc && echo 'eval "$(pyenv init -)"' >> ~/.zshrc && echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
```
4. Restart your terminal or run `source ~/.bashrc`, `source ~/.bash_profile`, or `source ~/.zshrc` to apply the changes.

## Installing Python versions
- Use `pyenv install <version>` to install the desired Python version, e.g., `pyenv install 3.9.5`.
```bash
pyenv install <version>
```

## Setting the global Python version
- Set the global Python version with `pyenv global <version>`, e.g., `pyenv global 3.9.5`.
```bash
pyenv global <version>
```

## Setting the local Python version
- Set the local Python version with `pyenv local <version>` in your project directory.
```bash
pyenv local <version>
```

## Listing installed Python versions
- List all installed Python versions with `pyenv versions`.
```bash
pyenv versions
```

## Listing available Python versions
- List all available Python versions with `pyenv install --list`.
```bash
pyenv install --list
```

## Using a specific Python version
- Use a specific Python version in the current shell session with `pyenv shell <version>`, e.g., `pyenv shell 3.9.5`.
```bash
pyenv shell <version>
```

## Uninstalling Python versions
- Uninstall a specific Python version with `pyenv uninstall <version>`, e.g., `pyenv uninstall 3.9.5`.
```bash
pyenv uninstall <version>
```

## Creating virtual environments
- Create a virtual environment with `pyenv virtualenv <version> <env_name>`, e.g., `pyenv virtualenv 3.9.5 myenv`.
```bash
pyenv virtualenv <version> <env_name>
```

## Activating and deactivating virtual environments
- Activate a virtual environment with `pyenv activate <env_name>` and deactivate with `pyenv deactivate` or `source deactivate`.
```bash
pyenv activate <env_name>
```
```bash
pyenv deactivate
```
```bash
source deactivate
```

## Listing virtual environments
- List all virtual environments with `pyenv virtualenvs`.
```bash
pyenv virtualenvs
```

## Using a virtual environment
- Use a virtual environment in the current shell session with `pyenv shell <env_name>`, e.g., `pyenv shell myenv`.
```bash
pyenv shell <env_name>
```

## Deleting virtual environments
- Delete a virtual environment with `pyenv virtualenv-delete <env_name>`.
```bash
pyenv virtualenv-delete <env_name>
```

## Cloning virtual environments
- Clone a virtual environment with `pyenv virtualenv <existing_env> <new_env>`, e.g., `pyenv virtualenv myenv myenv_clone`.
```bash
pyenv virtualenv <existing_env> <new_env>
```

## Renaming virtual environments
- Rename a virtual environment by cloning it with a new name and deleting the original.
```bash
pyenv virtualenv <existing_env> <new_env>
pyenv virtualenv-delete <existing_env>
```

## Setting the local virtual environment
- Set the local virtual environment with `pyenv local <env_name>` in your project directory.
```bash
pyenv local <env_name>
```

## Removing virtual environments
- Remove a virtual environment with `pyenv uninstall <env_name>`.
```bash
pyenv uninstall <env_name>
```

## Using pyenv with a Python project
- Use a `.python-version` file in your project directory to specify the Python version to use with `pyenv`.

###  Using pyenv with a Python project

To use pyenv with a Python project, follow these steps:

1. **Create a `.python-version` file**:
   - In your project's root directory, create a file named `.python-version`.

2. **Specify the Python version**:
   - In the `.python-version` file, write the desired Python version number, e.g., `3.9.5`.

3. **Activate the Python version**:
   - Navigate to your project directory in the terminal.
   - Use `pyenv local <version>` to set the local Python version for the project, e.g., `pyenv local 3.9.5`.

4. **Verify the Python version**:
   - Run `python --version` in the project directory to ensure that the correct Python version is being used.

5. **Install project dependencies**:
   - If your project uses dependencies managed by pip, install them using the correct Python version. You can do this within the activated environment.

6. **Deactivate the Python version (optional)**:
   - If you no longer need the project-specific Python version, you can deactivate it using `pyenv local --unset`.

Using pyenv in this way allows you to isolate Python environments for different projects, ensuring that each project uses its own specific Python version and dependencies.


