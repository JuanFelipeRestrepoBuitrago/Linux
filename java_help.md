# Managing Java Versions with SDKMAN!

## Installation of SDKMAN!
- Install `SDKMAN!` by following the instructions on the [SDKMAN! website](https://sdkman.io/install).

## Installing Java versions
- Use `sdk install java <version>` to install the desired Java version, e.g., `sdk install java 11.0.12-zulu`.
```bash
sdk install java <version>
```

## Setting the default Java version
- Set the default Java version with `sdk default java <version>`, e.g., `sdk default java 11.0.12-zulu`.
```bash
sdk default java <version>
```

## Using a specific Java version
- Use a specific Java version in the current shell session with `sdk use java <version>`, e.g., `sdk use java 11.0.12-zulu`.
```bash
sdk use java <version>
```

## Listing installed Java versions
- List all installed Java versions with `sdk list java`.
```bash
sdk list java
```

## Listing available Java versions
- List all available Java versions with `sdk list java` and `sdk list java | grep installed`.
```bash
sdk list java
```
```bash
sdk list java | grep installed
```

## Setting Java version for a project
- Create a `.sdkmanrc` file in your project directory with the desired Java version number, e.g., `11.0.12-zulu`.
```bash
echo "<version>" > .sdkmanrc
```
- Use `sdk use java` in your project directory to automatically switch to the specified Java version.
```bash
sdk use java
```

## Using SDKMAN! with Maven and Gradle
- After switching Java versions with SDKMAN!, use `mvn` or `gradle` as usual to manage your project's dependencies.

Using SDKMAN! allows you to manage multiple Java versions on your system and easily switch between them for different projects.
