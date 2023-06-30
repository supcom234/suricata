# zarf-suricata-pkg

## Contribution Guide
To contribute to this project, please follow the steps below:
1. Ensure there is an issue that clearly describes the purpose and scope of your contribution.
1. Create a new branch, named to clearly reflect the issue it corresponds to.
    * This is trivial using the [Development side bar on the issue page](https://docs.github.com/en/issues/tracking-your-work-with-issues/creating-a-branch-for-an-issue).
1. Make and commit your code changes to the new branch.
1. Once all of your changes have been made, checkout the [dco-core repository](https://github.com/naps-dev/dco-core)
1. Create the same new branch in the [dco-core repository](https://github.com/naps-dev/dco-core).
    * This is trivial using the [Development side bar on the issue page](https://docs.github.com/en/issues/tracking-your-work-with-issues/creating-a-branch-for-an-issue).
1. Update the GitHub workflow yaml file corresponding to this repo (e.g. `suricata.yaml`) on your new branch in [dco-core's .github/workflows folder](https://github.com/naps-dev/dco-core/tree/main/.github/workflows) so:
    * `REF_NAME` variable matches the name of issue branch created earlier.
    * `REF_TYPE` variable to "branch".
1. Commit and push your changes to `dco-core` to trigger a test.
1. Find `<your_github_username> is building the Suricata package` in the list of actions on the [dco-core actions page](https://github.com/naps-dev/dco-core/actions)
1. If the action fails, you will need to check the outputs, fix any changes, and re-trigger the action.
1. If the action passes, append a short description of your changes to [this repo's `CHANGELOG.md`](./CHANGELOG.md). (These changes should be considered `Unreleased`.) Commit `CHANGELOG.md`.
    * TODO: automatically update CHANGELOG based on issue flagged as resolved by PR.
1. Submit a [pull request in this repo](../../pulls) from the issue branch to `main`, including [Closes Keywords](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/using-keywords-in-issues-and-pull-requests#linking-a-pull-request-to-an-issue) in the PR description to automatically close the issue when the PR is merged, e.g. "closes #24" or "closes <org>/<repo>#47".
1. _Note: If your pull request is accepted and merged into `main`:_
    * _The workflows on `dco-core` `main` still point to whatever tag it used for its last release._
    * _The issue branch created above in `dco-core` remains for any future integration testing._
    * _You will need to work with this repo's [`CODEOWNERS`](./CODEOWNERS) to get your commit tagged as a release and used by `dco-core`. Please look at the `dco-core` contribution guide for more information about what to do next._

## Tagging Guidelines
When tagging a commit for a new release, the tag should follow the following format. Note that we use a monotonically-increasing one-based suffix to indicate the release number for the aforementioned upstream version:

`v<suricata_version>-<number_of_releases_for_this_version>`

For example, if the suricata version used in the repo is version 7.0.0 and this is the fifth release in the repository for this version, the tag would be:

`v7.0.0-5`