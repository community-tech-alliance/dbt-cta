This document is about how to contribute to the `dbt-cta` repository (created and owned by Community Tech Alliance).

No matter who you are, if you spot an error, omission, or bug, you're welcome to open an issue in this repo!

## Bugs and Feature Requests

The best way to let us know about any problems, submit feature requests, or provide general feedback is to [submit an Issue](https://github.com/community-tech-alliance/dbt-cta/issues/new).

### Bugs

When reporting a bug, please include the following information:

- Your name, role, and organization
- How you are running dbt:
    - what dbt version are you running?
    - are you executing locally or using dbt cloud (or some other method)?
- If reporting an issue with the code, please provide a detailed description, including as much of the following as possible/applicable:
    - steps needed to replicate the problem you are seeing
    - full text of logs producing an error (or otherwise undesirable outcome)
    - screenshots
    - sample data (CSV or Google Sheet preferred)
    - if known, steps to remediate (in which case you might also consider forking the repo and submitting a Pull Request - see below)

### Feature Requests

When submitting a feature request, please let us know your name and organization and be as detailed as possible in your request. If you already know how to make your dreams come true, we invite you to submit a pull request from a fork of the repository.

Whether you submit an Issue or a Pull Request, someone from our team will be in touch to review and discuss your suggested changes.

## Public contributions

We're so glad you're thinking about contributing to CTA's dbt codebase! If you're unsure about anything, just [send us an email](mailto:help@techallies.org) with your question — or submit the issue or pull request anyway. The worst that can happen is you'll be politely asked to change something. We love all friendly contributions.

We encourage you to read this project's CONTRIBUTING policy (you are here), its [LICENSE](LICENSE.md), and its [README](README.md).

### Submitting Pull Requests

In order to submit a pull request with your suggested changes, please first [fork](https://github.com/community-tech-alliance/dbt-cta/) this repository and make your desired changes on that fork. Once you are ready to submit them for review, please [create a pull request from your fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork). A member of the CTA organization will apply any relevant labels and follow up with you about your pull request.

### Additonal Guidelines for Code Submissions

* Each vendor (eg. `google_analytics`, `mailchimp`, etc) should have only one set of dbt models. If you feel strongly that your organization has a specialized use case that should follow a custom set of data transformations, please reach out by submitting an Issue, or [shoot us an email](mailto:help@techallies.org). In general, though, our intent is to run a common set of dbt models for all data coming from a single source.
* Models should be based on the types configured in [dbt_project.yml](dbt_project.yml). This repo is designed so that all models use that file. If there is a model type that needs to be added for your use case, please add it to the dbt_project.yml and explain in your Pull Request why the new model is needed.
* Formatting: Until we implement this in CI/CD, please run `sqlfmt`, as follows:

```shell
pipenv install
...
cd YOUR_DIRECTORY
pipenv run sqlfmt  .
```

## Public domain

For detailed license information, see [LICENSE](LICENSE.md).