# tremr
This app is targeted for people with Parkinson's. It allows the user to measure the severity of hand tremors over time. In addition, the user can track medication use, and exercise. These three variables can be plotted, so that the user and/or a medical professional can visualize changes in tremor symtoms over time, and possibly correlate this with medication or exercise.

## Cloning and Building this Repo
This repository uses git submodules to manage dependencies, so when you clone, please run

`git clone --recurse-submodules https://github.com/nklaassen/tremr`

After cloning, run

`cd tremr`

`open tremr.xcodeproj`

This should open the project in XCode. At this point, make sure your build scheme is set to tremr > iPhone 8 Plus, and then you should be able to build and run the project.

Note: if you already cloned the project without `--recurse-submodules`, you may need to run `git submodule update --init --recursive` from within the project directory.

## Contributing
When contributing to this repository, we will try to follow the [GitHub Flow](https://help.github.com/articles/github-flow/):
1. Create a branch from the repository.
2. Create, edit, rename, move, or delete files.
3. Send a pull request from your branch with your proposed changes to kick off a discussion.
4. Make changes on your branch as needed. Your pull request will update automatically.
5. Merge the pull request once the branch is ready to be merged.
6. Tidy up your branches using the delete button in the pull request or on the branches page.

Pull requests will somewhat act as code reviews, and help us all to follow the code and features we are adding. The link above has more information about all of the steps, please refer to it if you have any questions.
