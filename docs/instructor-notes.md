---
title: "MIDS w205 - Fundamentals of Data Engineering"
author: "Instructor Notes"

---

This is a compilation of notes for and by instructors.  It will mostly focus on
tools, images, and grading.  We'll work to keep this up-to-date as we progress
through the first semester that this course is taught.

This document is intended to be live and is maintained in the `course-content`
repository under `docs/instructor-notes.md`.


# GitHub

It's in our student's best interest that they develop a strong working
knowledge of `git` and GitHub.

We recommend that instructors:

- drive all course content via GitHub.  This includes access to synchronous
  session slides, links to async videos, and any notes, readings, and links

- use GitHub Classroom to manage activity assignment and submission

Each instructor has a separate GitHub Organization

    mids-w205-<instructor>
    
to use for all sections they teach.


# GitHub Classroom

## `tl;dr`

Each student assignment:

- has a corresponding private repo shared by the student and instructor

- is created from a template repository that contains any setup for the
  activity.  This allows us to include things like `Dockerfile`s and/or
  docker-compose templates directly within an activity

- can be submitted as a pull request.  The grading process then consists of
  PR reviews

Note that this describes an _individual_ assignment, but _group_ assignments
work the same way, just using group access to an assignment repo.


## Creating Assignments

GitHub Classroom provides some tooling around assigning and submitting
solutions to student activities.  It's front-and-center in the GitHub Classroom
interface for the instructor and pretty transparent to the student.

Students can be added to an assignment through the GitHub Classroom UI, but
each assignment gets a unique link that's easily posted to a wall or pasted in
slack or chat.

### Creation Process

It's pretty much as simple as pick a name for the assignment and choose the
appropriate activity template.  I recommend marking them as `Private`,
_without_ student `Admin` access, and with no need for a deadline.  Marking
them as `Private` in this context means only the instructor and student have
access.  I'm not sure what happens with the deadline, I'll have to experiment.

To create:

- create new assignment
- select `individual`
- name the assignment (`signup`, `activity 01`, etc)
- mark it private
- mark it non-admin
- select the template from `mids-w205-fund-of-data-eng/template-<activity name>`
  e.g., `mids-w205-fund-of-data-eng/template-activity-signup`.  It'll use that
  repo as a template as it creates each student's repo for that assignment
- no deadline

Once the assignment is created, then existing students in the classroom can be
invited to participate in the activity via the invite link that github
classroom creates for each assignment.  You can always hand out the link to the
assignment in chat or on the wall for the class.


## A Student's View

### Signup

A student clicks through the first `signup` assignment link from slack or isvc.

They are presented with the options to:

- create a github account if they don't already have one
- self-associate their github account with their name in the github classroom
  roster

### Accepting an assignment

Throughout the semester, students can accept assignments once they're created
by clicking through each assignment's invite link.  There _may_ be other ways
students can see and accept assignments once they're already a member of the
classroom, but publishing each assignment's link to slack / isvc is preferred.

### Submitting a solution to an assignment

An assignment submission is at the very least a tag of the instructor's github
username on either a commit or PR comment.

When each student's assignment repo

    mids-w205-<instructor>/<assignment_name>-<student_gh_username>

is created, the instructor is also automatically added as admin for that repo.
The default GitHub watches enable you to receive notifications when you're
tagged via an `@`-mention (e.g., `@mmm` for me) in a commit or PR comment.

For this class, it makes sense for the students to learn at least some sort of
simplified branching git workflow.  Something like a simplified
[nvie](http://nvie.com/posts/a-successful-git-branching-model/) or `git-flow`.

A student will (this is the preferred approach):

- finish an assignment
- commit
- push to a branch
- create a new pull request
- tag the instructor in that PR
    - request a review from the instructor via the GitHub PR webui
    - `@`-mention the instructor in a comment or PR description

Alternatively, the following simplified workflow will work as well:

- finish an assignment
- commit (`@`-mention the instructor in the commit message)
- push that to the `master` branch of their assignment repo


## GitHub Classroom Setup

A GitHub classroom has already been created for each instructor organization.

### Bootstrapping

We'll bootstrap classrooms with a trivial `signup` assignment that lets the 
students:

- create a github account if they don't already have one
- self-associate their github account with their name in the github classroom
  roster
- walk through the assignment submission process

We recommend students use any existing GitHub accounts if they already have
them.  It's generally best to use a single GitHub account that follows you
around for life.

### Rosters

Before sending out the bootstrapping `signup` assignment, we need to add
rosters from all of your sections into each instructor's GitHub Classroom.  All
that's really needed is a csv of `{ Last, First }`, which is enough to let
students self-select when they join.  This "roster" then just becomes a mapping
of names to GitHub logins.

### Assignments and activity templates

Every assignment should have an associated activity template (repository).  For
example, 

    mids-w205-fund-of-data-eng/template-activity-signup

or 

    mids-w205-fund-of-data-eng/template-activity-01

These are just a template repository for each activity that will be used
as the source when instantiating each student's assignment repo.

When creating new assignments, instructors can a.) simply use the
`mids-w205-fund-of-data-eng` templates provided or b.) create forked and
specialized activity templates within their own orgs.


Check out <https://classroom.github.com/videos> for more info.


# Cloud Accounts

## AWS and GCP

Students will directly use a variety of AWS and GCP services throughout this
course.  We'll prefer that students create free-tier individual accounts with
AWS and GCP (we walk them through this process during the second class).  If a
student has already spent their free tier, there are potential sources of help
from the department.  Let's try to take that on a case-by-case basis.

## DigitalOcean

We have a DigitalOcean account for MIDS w205 instructors with resources
available to stand up an instance per-student for the duration of the
semester.

There's a MachineLearning One-Click (MLOC) image that provides a handful
of particularly useful tools for this class right out of the box:

- common python (2&3) ML tools and libraries
- common R tools and libraries
- jupyterhub
    - with terminal access!
    - `basic_auth` over bare `http`, so be careful
- r-studio server
    - `basic_auth` over bare `http`, so be careful
    

# Cloud and Container Images

TODO: Most of what we do will be included in the activity template repos,
but it's worth going over some basic requirements we have here.


# Keeping Things Fresh

In order to keep this course as up-to-date as possible, we've chosen to capture
the bulk of the course content as individually-created screencasts and use fewer
studio-recorded lectures.

There's also a good deal of the content for this course that is still under
various forms of construction... recording, editing, etc.
You'll see `under-construction.png` gaps.

To accommodate this, the `course-content` repo in your GitHub organization

    mids-w205-<instructor>/course-content

is a fork of the main development repo, 

    mids-w205-fund-of-data-eng/course-content

Please help throughout this process by keeping your fork up-to-date with this
"upstream" as the content is completed.

### Refresh from upstream

Here's a basic workflow to refresh from upstream

    git clone git@github.com:<my-org>/course-content
    cd course-content
    git remote add upstream git@github.com:mids-w205-fund-of-data-eng/course-content
    git pull --all
    git merge upstream/master
    git push origin master

