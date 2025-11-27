# Pipeline POC

---

## Get familiar with the project structure

The project is organized into the following directories:

- `src/`: Source code for the calculator
- `tests/`: Unit tests for the calculator
- `operation.json`: Configuration file for the calculator
- `Makefile`: Makefile for the project

**Github Repository:** https://github.com/acactown/simple-pipeline-poc

---

## Tasks to complete

- [ ] **DMPINV-101:** Fix the *multiplication* operation issue
- [ ] **DMPINV-102:** Update the `README.md` file to include the *multiplication* operation
- [ ] **DMPINV-202:** Add tests for the *division* operation
- [ ] **DMPINV-303:** Add a new *subtraction* operation to the calculator

---

## EditorConfig - Code Style

> A tool to help maintain consistent coding styles between different editors and IDEs.

![tabs-spaces](./docs/tabs-spaces.png)

The EditorConfig project consists of a file format for defining coding styles and a collection of text editor plugins that enable editors to read the file format and adhere to defined styles. EditorConfig files are easily readable and they work nicely with version control systems.

The EditorConfig file is a simple text file that defines the coding styles for a project. It is used to maintain consistency across different editors and IDEs.

## EditorConfigChecker - Code Style Checker

> A tool to help maintain consistent coding styles between different editors and IDEs.

![editorconfig-checker](./docs/editorconfig-checker.png)

---

## ShellCheck - Shell Script Linting

> A static analysis tool for shell scripts that helps catch common errors and improve script quality.

![shellcheck](./docs/shellcheck.png)

ShellCheck is a GPLv3 tool that gives warnings and suggestions for bash/sh shell scripts. It can help you find:

- Syntax errors that can cause a shell script to fail
- Semantic problems that may cause a shell to behave strangely or incorrectly
- Subtle caveats, corner cases, and pitfalls that may cause an advanced user's otherwise working script to fail under future circumstances

---

## Conventional Commits

> The specification for adding human and machine readable meaning to commit messages.

![conventional-commits](./docs/conventional-commits.png)

The Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of. This convention describes the **features**, **fixes**, and **breaking changes** made in commit messages.

The **commit message** should be structured as follows:

```
<type>: [task-id] <description>

[optional body]

[optional footer(s)]
```

The commit contains the following structural elements, to communicate intent:

1. **fix:** a commit of the type `fix:` patches a bug in your codebase.
2. **feat:** a commit of the type `feat:` introduces a new feature to the codebase.
3. **BREAKING CHANGE:** a commit that has a footer `BREAKING CHANGE`:, or appends a `!` after the type/scope, introduces a breaking API. A BREAKING CHANGE can be part of commits of any type.
4. **types other than fix & feat:**

- `chore:` routine tasks that are not specific to a feature or a bug, such as adding content to the `.gitignore` file or installing a dependency.
- `test:` when we add or fix tests.
- `docs:` when only documentation is modified.
- `build:` when the change affects the project's build/compilation.
- `ci:` the change affects configuration files and scripts related to continuous integration.
- `style:` readability or code formatting changes that do not affect functionality.
- `refactor:` code change that neither fixes bugs nor adds functionality, but improves the code.
- `perf:` used for performance improvements.
- `revert:` if the commit reverts a previous commit. The hash of the commit being reverted should be indicated.

## Commitlint - Commit Message Linter

> A tool to help enforce Conventional Commits.

![commitlint](./docs/commitlint.png)

It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of. This convention describes the **features**, **fixes**, and **breaking changes** made in commit messages.

---
